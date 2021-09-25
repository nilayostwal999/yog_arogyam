import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yog_arogyam/meetingmodel.dart';
import 'UserModel.dart';
import 'requestModel.dart';
import 'globals.dart' as globals;
import 'package:yog_arogyam/UserDetailsModel.dart';

class Adminpage extends StatefulWidget {
  @override
  _AdminpageState createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  MeetingModel meetDetails = new MeetingModel();
  DateTime selectedDate = DateTime.now();
  DateTime meetingDate = DateTime.now();
  TimeOfDay meetingTime = TimeOfDay.now();
  RequestModel request;
  final db = Firestore.instance;
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
          title: Text('Yog Arogyam - Admin - Requests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
                stream: Firestore.instance.collection('requests').snapshots(),
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
    var request = RequestModel.toObject(document);
    request.id = document.documentID;

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
                            text: 'Name : ' +
                                request.firstName +
                                ' ' +
                                request.lastName,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'E-mail : ' + request.email,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Mobile : ' + request.mobile,
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
                                .document(request.email)
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
                                .document(request.email)
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
                            globals.mobile = request.mobile;
                            await Navigator.pushNamed(context, 'HistoryPage');
                          },
                          child: Text('View History'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                        content: new SingleChildScrollView(
                                          child: new ListBody(
                                            children: [
                                              Text('Date of Meeting : ' +
                                                  meetingDate
                                                      .toString()
                                                      .split(' ')[0]),
                                              RaisedButton(
                                                onPressed: () async {
                                                  final DateTime picked =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              selectedDate,
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2101));
                                                  if (picked != null &&
                                                      picked != selectedDate)
                                                    setState(() {
                                                      meetingDate = picked;
                                                    });
                                                },
                                                child: Text('Change Date'),
                                              ),
                                              Text('Time of Meeting : ' +
                                                  meetingTime
                                                      .toString()
                                                      .substring(10, 15)),
                                              RaisedButton(
                                                onPressed: () async {
                                                  final TimeOfDay picked =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              meetingTime,
                                                          builder: (BuildContext
                                                                  context,
                                                              Widget child) {
                                                            return MediaQuery(
                                                              data: MediaQuery.of(
                                                                      context)
                                                                  .copyWith(
                                                                      alwaysUse24HourFormat:
                                                                          false),
                                                              child: child,
                                                            );
                                                          });

                                                  if (picked != null &&
                                                      picked != meetingTime)
                                                    setState(() {
                                                      meetingTime = picked;
                                                    });
                                                },
                                                child: Text('Change Time'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: Text('Meeting Details'),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text('Save'),
                                            onPressed: () async {
                                              meetDetails.name =
                                                  request.firstName +
                                                      ' ' +
                                                      request.lastName;
                                              meetDetails.date = meetingDate
                                                  .toString()
                                                  .split(' ')[0];
                                              meetDetails.time = meetingTime
                                                  .toString()
                                                  .substring(10, 15);
                                              meetDetails.email = request.email;
                                              meetDetails.mobile =
                                                  request.mobile;
                                              var meetingMap =
                                                  meetDetails.toMap();
                                              await db
                                                  .collection('meetings')
                                                  .document(meetingDate
                                                          .toString()
                                                          .split(' ')[0] +
                                                      ' ' +
                                                      meetingTime
                                                          .toString()
                                                          .substring(10, 15))
                                                  .setData(meetingMap);
                                              await db
                                                  .collection('users')
                                                  .document(request.email)
                                                  .updateData(
                                                      {'firstMeet': false});
                                              await db
                                                  .collection('requests')
                                                  .document(request.id)
                                                  .delete()
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            },
                                          ),
                                        ]);
                                  });
                                });
                          },
                          child: Text('Meeting Data'),
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
