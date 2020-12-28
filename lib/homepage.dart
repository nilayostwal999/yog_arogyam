import 'package:flutter/material.dart';
import 'package:yog_arogyam/globals.dart' as globals;

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
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
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Consultation');
                },
                child: Text(
                  'Book a\nConsultation',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                color: Colors.blue,
              )
            ]),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                    hintText:
                        'Present Medical Problems\nLike arthirits, diabetes, Thyroid, Etc'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                    hintText:
                        'Family Medical History (if any)\nLike Heart Conditons, diabetes, allergies, Etc'),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue[400],
              )
            ],
          ),
        ));
  }
}
