import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class MedicalReports extends StatefulWidget {
  @override
  _MedicalReportsState createState() => _MedicalReportsState();
}

class _MedicalReportsState extends State<MedicalReports> {
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
            onPressed: () {},
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
    );
  }
}
