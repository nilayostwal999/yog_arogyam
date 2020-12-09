import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    "Hello firstName!\nUsername",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text('email'),
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
                  title: Text('My Posts',
                      style: TextStyle(
                          color: Colors.lightBlue[800], fontSize: 20)),
                  onTap: () {
                    Navigator.pushNamed(context, 'MyPosts');
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
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('posts')
                    .orderBy("dateCreated", descending: true)
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

  _buildPostCard(BuildContext context, DocumentSnapshot document) {}
}
