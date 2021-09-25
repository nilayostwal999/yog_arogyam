import 'package:flutter/material.dart';
import 'package:yog_arogyam/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yog_arogyam/requestModel.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  RequestModel requestModel = new RequestModel();
  DateTime selectedDate = DateTime.now();
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  var height;
  var weight;
  var age;
  var problems;
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
                    "Hello! " +
                        globals.currentUser.firstName +
                        " " +
                        globals.currentUser.lastName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(globals.currentUser.email),
                ),
                ListTile(
                  title: Text('Home',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'HomePage', ModalRoute.withName('/'));
                  },
                ),
                ListTile(
                  title: Text('Profile',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamed(context, 'Profile');
                  },
                ),
                ListTile(
                  title: Text('Medical Reports',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamed(context, 'Reports');
                  },
                ),
                // ListTile(title: Text('Saved Posts',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamed(context,'SavedPosts');},),
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
          elevation: 20,
          title: Text(
            'Yog Arogyam',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
        body: Container(
            child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/img/logo_title.jpg')),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter your Height'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  height = value.trim();
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter your Weight'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  weight = value.trim();
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Enter Your Age'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  age = value.trim();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText:
                        'Enter your Health Problems / Diseases\nseparated by commas(,)'),
                maxLines: null,
                minLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  problems = value.trim();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () async {
                    requestModel.email = globals.currentUser.email;
                    requestModel.firstName = globals.currentUser.firstName;
                    requestModel.lastName = globals.currentUser.lastName;
                    requestModel.mobile = globals.currentUser.mobile;
                    var requestMap = requestModel.toMap();
                    // Store user in Database
                    _formKey.currentState.save();
                    print(height + weight + age + problems);
                    Firestore.instance
                        .collection('users')
                        .document(globals.currentUser.email)
                        .collection('Records')
                        .document('details')
                        .setData({
                      "height": height,
                      "weight": weight,
                      "age": age,
                      "problems": problems
                    });
                    await db
                        .collection('requests')
                        .document(globals.currentUser.email)
                        .setData(requestMap);
                    // await showDialog(
                    //     context: context,
                    //     child: AlertDialog(
                    //       title: Text('Request Raised'),
                    //       content: Text(
                    //           'Your data hade been submitted and request have been raised and soon you will get the callback to fix the meeting date and time.'),
                    //       actions: [
                    //         RaisedButton(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: Text('OK'),
                    //         )
                    //       ],
                    //     ));
                  },
                  child: Text('Submit data and\nRaise a Request'),
                ),
              ),
            ],
          ),
        )));
  }
}
