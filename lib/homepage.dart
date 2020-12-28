import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yog_arogyam/PostModel.dart';
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

  _buildPostCard(BuildContext context, DocumentSnapshot document) {
    var post = PostModel.toObject(document);
    post.id = document.documentID;

    return Card(
        child: InkWell(
            onTap: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostScreen(
                        post)), // the builder of MaterialPageRoute will call the TodoDetail class passing the todo that was passed.
              ); */
            },
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
                      children: [
                        RichText(
                            text: TextSpan(
                                text: post.title,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.lightBlue[800],
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('@' + post.username,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(post.dateCreated,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey))
                          ],
                        ),
                        Center(
                            child: (post.mediaPath != null)
                                ? Image.network(
                                    post.mediaPath,
                                    fit: BoxFit.contain,
                                    height: 250,
                                  )
                                : Text('')),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            text: TextSpan(
                                text: post.description,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black))),
                        Center(
                            child: Text('Read More and View Resources',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)))
                      ],
                      // crossAxisAlignment: CrossAxisAlignment.start,
                    )))));
  }
}
