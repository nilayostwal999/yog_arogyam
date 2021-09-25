import 'dart:math';

import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'reportModel.dart';

class AdminReports extends StatefulWidget {
  @override
  _AdminReportsState createState() => _AdminReportsState();
}

class _AdminReportsState extends State<AdminReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Reports',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(5),
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(globals.currentUser.email)
                  .collection('reports')
                  .orderBy("dateCreated", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('No reports available!!');
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: min(snapshot.data.documents.length, 8),
                    itemBuilder: (context, index) => _buildReportCards(
                        context, snapshot.data.documents[index]));
              })),
    );
  }

  Widget _buildReportCards(BuildContext context, DocumentSnapshot document) {
    var resource = ReportModel.toObject(document);
    resource.id = document.documentID;

    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid, color: Colors.black)),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        children: <Widget>[
          Image(image: NetworkImage(resource.imagepath)),
          Row(
            children: <Widget>[
              Text(
                resource.dateCreated.substring(8) +
                    '-' +
                    resource.dateCreated.substring(5, 7) +
                    '-' +
                    resource.dateCreated.substring(0, 4),
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
