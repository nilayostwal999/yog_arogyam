import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yog_arogyam/historyModel.dart';
import 'package:yog_arogyam/globals.dart' as globals;

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Yog Arogyam - Admin - History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
                stream: db
                    .collection('History')
                    .where('mobile', isEqualTo: globals.mobile)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: Text(
                      "There haven't been any meetings yet",
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ));
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => _buildHistoryCard(
                          context, snapshot.data.documents[index]));
                })));
  }

  _buildHistoryCard(BuildContext context, DocumentSnapshot document) {
    var historyDoc = HistoryModel.toObject(document);
    historyDoc.id = document.documentID;
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
                    Text('Name : ' + historyDoc.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                    Text('Email : ' + historyDoc.email,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text('Mobile : ' + historyDoc.mobile,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(
                        'Meeting Date and Time : ' +
                            historyDoc.date.substring(8) +
                            '-' +
                            historyDoc.date.substring(5, 7) +
                            '-' +
                            historyDoc.date.substring(0, 4) +
                            ' ' +
                            historyDoc.time,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Text('Problems : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(historyDoc.problems,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Yogas Prescribed : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(historyDoc.yogas,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ))));
  }
}
