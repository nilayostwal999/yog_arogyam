import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yog_arogyam/UserDetailsModel.dart';
import 'package:yog_arogyam/UserModel.dart';
import 'package:yog_arogyam/historyModel.dart';
import 'package:yog_arogyam/meetingmodel.dart';
import 'globals.dart' as globals;

class AdminpageMeetings extends StatefulWidget {
  @override
  _AdminpageMeetingsState createState() => _AdminpageMeetingsState();
}

class _AdminpageMeetingsState extends State<AdminpageMeetings> {
  final _formKey = GlobalKey<FormState>();
  var yogas;
  HistoryModel history = new HistoryModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
              addRepaintBoundaries: true,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    child:
                        Image(image: AssetImage('assets/img/logo_title.jpg'))),
                ListTile(
                  title: Text('Requests',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'AdminPageRequests', ModalRoute.withName('/'));
                  },
                ),
                ListTile(
                  title: Text('Meetings',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'AdminPageMeetings');
                  },
                ),
                ListTile(
                  title: Text('History',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'HistorySearch');
                  },
                ),
                ListTile(
                  title: Text('Logout',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'SignIn', ModalRoute.withName('/'));
                  },
                )
              ]),
        ),
        appBar: AppBar(
          title: Text('Yog Arogyam - Admin - Meetings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
                stream: Firestore.instance.collection('meetings').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: Text(
                      'There are no Requests left today...',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ));
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => _buildPostCard(
                          context, snapshot.data.documents[index]));
                })));
  }

  Widget _buildPostCard(BuildContext context, DocumentSnapshot document) {
    var meetingData = MeetingModel.toObject(document);
    meetingData.id = document.documentID;
    return Card(
        child: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                    color: Colors.grey,
                    width: 2,
                    style: BorderStyle.values[1])),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Name : ' + meetingData.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'E-mail : ' + meetingData.email,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Mobile : ' + meetingData.mobile,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Date and Time : ' +
                                meetingData.date.substring(8) +
                                '-' +
                                meetingData.date.substring(5, 7) +
                                '-' +
                                meetingData.date.substring(0, 4) +
                                ' ' +
                                meetingData.time,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            DocumentSnapshot userDoc = await Firestore.instance
                                .collection('users')
                                .document(meetingData.email)
                                .get();
                            globals.currentUser = UserModel.toObject(userDoc);
                            await Navigator.pushNamed(context, 'AdminReports');
                          },
                          child: Text("View Reports"),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            var userDetailsDoc = await Firestore.instance
                                .collection('users')
                                .document(meetingData.email)
                                .collection('Records')
                                .document('details')
                                .get();
                            globals.userDetails =
                                UserDetailsModel.toObject(userDetailsDoc);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                        content: new SingleChildScrollView(
                                          child: new ListBody(
                                            children: [
                                              Text('Height : ' +
                                                  globals.userDetails.height),
                                              Text('Weight : ' +
                                                  globals.userDetails.weight),
                                              Text('Age : ' +
                                                  globals.userDetails.age),
                                              Text('Problems : ' +
                                                  globals.userDetails.problems)
                                            ],
                                          ),
                                        ),
                                        title: Text('User Details'),
                                        actions: <Widget>[
                                          RaisedButton(
                                              child: Text('Close'),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              })
                                        ]);
                                  });
                                });
                          },
                          child: Text('View Details'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            globals.meeting = MeetingModel.toObject(document);
                            globals.mobile = globals.meeting.mobile;
                            await Navigator.pushNamed(context, 'HistoryPage');
                          },
                          child: Text('View History'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                        content: new SingleChildScrollView(
                                          child: new ListBody(
                                            children: [
                                              Form(
                                                key: _formKey,
                                                child: TextFormField(
                                                  maxLines: null,
                                                  minLines: null,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          'Enter Names of yogas prescribed.'),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    yogas = value.trim();
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        title: Text('Prescribe Yogas'),
                                        actions: <Widget>[
                                          RaisedButton(
                                              child: Text('Save'),
                                              onPressed: () async {
                                                _formKey.currentState.save();
                                                print(yogas);
                                                await Firestore.instance
                                                    .collection('users')
                                                    .document(meetingData.email)
                                                    .collection('yogas')
                                                    .document(meetingData.date)
                                                    .setData({"yogas": yogas});
                                                history.date = meetingData.date;
                                                history.time = meetingData.time;
                                                history.name = meetingData.name;
                                                history.problems = globals
                                                    .userDetails.problems;
                                                history.email =
                                                    meetingData.email;
                                                history.yogas = yogas;
                                                history.mobile =
                                                    meetingData.mobile;
                                                var historyMap =
                                                    history.toMap();
                                                await Firestore.instance
                                                    .collection('History')
                                                    .document(meetingData.date +
                                                        ' ' +
                                                        meetingData.time)
                                                    .setData(historyMap);
                                                await Firestore.instance
                                                    .collection('meetings')
                                                    .document(meetingData.date +
                                                        ' ' +
                                                        meetingData.time)
                                                    .delete();
                                                Navigator.pop(context);
                                              })
                                        ]);
                                  });
                                });
                          },
                          child: Text("Prescribe Yogas"),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
