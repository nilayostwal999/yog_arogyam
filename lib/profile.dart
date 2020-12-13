import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:yog_arogyam/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                  radius: 100,
                  backgroundImage: (globals.currentUser.imagePath != null)
                      ? NetworkImage(globals.currentUser.imagePath)
                      : AssetImage('assets/img/logo.png')),
            ),
            Positioned(
                top: 180,
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      getImage().then((value) async => {
                            deleteImage(),
                            uploadFile().then((value) async => {
                                  globals.currentUser.imagePath = value,
                                  await Firestore.instance
                                      .collection('users')
                                      .document(globals.currentUser.email)
                                      .setData({
                                    'imagePath': globals.currentUser.imagePath
                                  }, merge: true),
                                  await Navigator.pushReplacementNamed(
                                      context, 'Profile')
                                })
                          });
                    },
                  ),
                  backgroundColor: Colors.lightBlue[800],
                )),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    globals.currentUser.email,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle, color: Colors.black),
                  SizedBox(width: 10.0),
                  Text(
                    globals.currentUser.firstName +
                        ' ' +
                        globals.currentUser.lastName,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.call, color: Colors.black),
                  SizedBox(width: 10.0),
                  Text(
                    globals.currentUser.mobile,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadFile() async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(_image.path)}');
    final StorageUploadTask uploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future deleteImage() async {
    RegExp regExp = new RegExp(
      r"com\/o(.*?)\?alt",
      caseSensitive: false,
      multiLine: false,
    );

    var mediaPath = regExp
        .firstMatch(globals.currentUser.imagePath)
        .group(1)
        .replaceAll('%2F', '/');
    // delete image from firestorage
    await FirebaseStorage.instance.ref().child(mediaPath).delete();
  }
}
