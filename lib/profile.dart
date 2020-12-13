import 'package:flutter/material.dart';
import 'package:yog_arogyam/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(globals.currentUser.email),
              ),
            ),
            SizedBox(height: 15.0),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.account_circle, color: Colors.black),
                title: Text(
                  globals.currentUser.firstName +
                      ' ' +
                      globals.currentUser.lastName,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.call, color: Colors.black),
                title: Text(
                  globals.currentUser.mobile,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.cake, color: Colors.black),
                title: Text(globals.currentUser.dob[8] +
                    globals.currentUser.dob[9] +
                    globals.currentUser.dob[7] +
                    globals.currentUser.dob[5] +
                    globals.currentUser.dob[6] +
                    globals.currentUser.dob[7] +
                    globals.currentUser.dob[0] +
                    globals.currentUser.dob[1] +
                    globals.currentUser.dob[2] +
                    globals.currentUser.dob[3]),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.my_location,
                  color: Colors.black,
                ),
                title: Text(globals.currentUser.city +
                    ', ' +
                    globals.currentUser.state +
                    ', ' +
                    globals.currentUser.country),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
