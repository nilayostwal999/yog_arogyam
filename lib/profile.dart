import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                title: Text('My Posts',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.pushNamed(context, 'MyPosts');
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
        title: Text('Your Profile',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ProfileEdit');
            },
            child: Row(children: [
              Icon(Icons.edit),
              Text('Edit Profile', style: TextStyle(fontSize: 20))
            ]),
            color: Colors.blue[500],
            textColor: Colors.white,
          )
        ],
      ),
      body: ListView(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          children: [
            /* SizedBox(
              width: 200,
              height: 250,
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                    top: 220,
                    child: Text('Username',
                        style: TextStyle(
                            color: Colors.lightBlue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        textAlign: TextAlign.center)),
                Positioned(
                  top: 7,
                  width: 200,
                  height: 200,
                  child: CircleAvatar(
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
                                        'imagePath':
                                            globals.currentUser.imagePath
                                      }, merge: true),
                                      await Navigator.pushReplacementNamed(
                                          context, 'Profile')
                                    })
                              });
                        },
                      ),
                      backgroundColor: Colors.lightBlue[800],
                    ))
              ]),
            ), */
            Card(
                margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                child: Row(
                  children: [
                    Text('Name:', style: TextStyle(fontSize: 20)),
                    Text(capitalize('firstName') + ' ' + capitalize('lastName'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('City:', style: TextStyle(fontSize: 20)),
                    Text(capitalize('city'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('State:', style: TextStyle(fontSize: 20)),
                    Text(capitalize('state'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Country:', style: TextStyle(fontSize: 20)),
                    Text(capitalize('country'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Mobile:', style: TextStyle(fontSize: 20)),
                    Text(capitalize('mobile no.'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('E-mail ID:', style: TextStyle(fontSize: 20)),
                    Expanded(
                      child: Text('email',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            // Card(
            //     margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            //     child: Row(
            //       children: [
            //         Text('Password:', style: TextStyle(fontSize: 20)),
            //         RaisedButton(
            //           onPressed: () {
            //             Navigator.pushNamed(context, 'ChangePassword');
            //           },
            //           child: Text('Change Password',
            //               style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white)),
            //           color: Colors.lightBlue[800],
            //         ),
            //       ],
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //     )),
          ]),
    );
  }

  String capitalize(word) {
    return "${word[0].toUpperCase()}${word.substring(1)}";
  }
}
