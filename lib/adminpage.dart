import 'package:flutter/material.dart';
import 'package:yog_arogyam/meetingmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adminpage extends StatefulWidget {
  @override
  _AdminpageState createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  DateTime selectedDate = DateTime.now();
  MeetingModel meeting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Yog Arogyam - Admin          ' +
                  "${selectedDate.toLocal()}".split(' ')[0][8] +
                  "${selectedDate.toLocal()}".split(' ')[0][9] +
                  '-' +
                  "${selectedDate.toLocal()}".split(' ')[0][5] +
                  "${selectedDate.toLocal()}".split(' ')[0][6] +
                  '-' +
                  "${selectedDate.toLocal()}".split('-')[0],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('meetings')
                    .document("${selectedDate.toLocal()}".split(' ')[0])
                    .collection('Slots')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: Text(
                      'You haven\'t posted anything yet...',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ));
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => _buildPostCard(
                          context, snapshot.data.documents[index]));
                })));
  }

  Widget _buildPostCard(BuildContext context, DocumentSnapshot document) {
    var meeting = MeetingModel.toObject(document);
    meeting.id = document.documentID;

    return Card(
        child: InkWell(
            onTap: () {},
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
                                text: 'Slot : ' + meeting.slot,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.lightBlue[800],
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'E-mail : ' + meeting.email,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.lightBlue[800],
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text('View Reports',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)))
                      ],
                    )))));
  }
}
