import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'reportModel.dart';

class MedicalReports extends StatefulWidget {
  @override
  _MedicalReportsState createState() => _MedicalReportsState();
}

class _MedicalReportsState extends State<MedicalReports> {
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
            addRepaintBoundaries: true,
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  "Hello " + globals.currentUser.firstName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(globals.currentUser.email),
              ),
              // DrawerHeader(
              //   child: Column(
              //     children: <Widget>[
              //       // CircleAvatar(backgroundImage: ,),

              //       Text('Fake To Nahin',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 24,
              //               color: Colors.white)),
              //     ],
              //   ),
              //   decoration: BoxDecoration(color: Colors.lightBlue[800]),
              // ),
              ListTile(
                title: Text('Home',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'HomePage', ModalRoute.withName('/'));
                },
              ),
              ListTile(
                title: Text('Profile',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.pushNamed(context, 'Profile');
                },
              ),
              ListTile(
                title: Text('Medical Reports',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.pushNamed(context, 'Reports');
                },
              ),
              // ListTile(title: Text('Saved Posts',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamed(context,'SavedPosts');},),
              ListTile(
                title: Text('Logout',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'SignIn', ModalRoute.withName('/'));
                },
              )
            ]),
      ),
      appBar: AppBar(
        title: Text(
          'Medical Reports',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        actions: [
          RaisedButton(
            onPressed: () async {
              getImage().then((value) async => {
                    uploadFile().then((value) async => {
                          addResourceToPost(value)
                          // .then((value) async => await showDialog(
                          // context: context,
                          // child: AlertDialog(
                          //   title: Text('Report Uploaded'),
                          //   content:
                          //       Text('Your Report hade been uploaded.'),
                          //   actions: [
                          //     RaisedButton(
                          //       onPressed: () {
                          //         Navigator.pushReplacementNamed(
                          //             context, 'Reports');
                          //       },
                          //       child: Text('OK'),
                          //     )
                          //   ],
                          // )))
                        }),
                  });
            },
            child: Text(
              'Upload a\nReport',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
            color: Colors.blue,
          )
        ],
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
                if (!snapshot.hasData) return Text('No comments yet!!');
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => _buildReportCards(
                        context, snapshot.data.documents[index]));
              })),
    );
  }

  Future addResourceToPost(value) async {
    ReportModel newReport =
        ReportModel(DateTime.now().toString().split(' ')[0], value);

    await Firestore.instance
        .collection('users')
        .document(globals.currentUser.email)
        .collection('reports')
        .add(newReport.toMap());
  }

  Future<String> uploadFile() async {
    var storageReference = FirebaseStorage.instance.ref().child(
        'reports/${globals.currentUser.email}/${Path.basename(_image.path)}');
    final StorageUploadTask uploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
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

      // DecoratedBox(
      //     decoration: BoxDecoration(
      //         color: resource.summary == "real" ? Colors.green : Colors.red,
      // ))
    );
  }
}
