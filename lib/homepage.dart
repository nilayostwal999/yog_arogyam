import 'package:flutter/material.dart';

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
        body: Card(
            child: InkWell(
                onTap: () {},
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
                                    text: 'Yoga Name',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.lightBlue[800],
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                                text: TextSpan(
                                    text: 'description',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black))),
                            Center(
                                child: Text('Click to see instructions',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline)))
                          ],
                          // crossAxisAlignment: CrossAxisAlignment.start,
                        ))))));
  }
}
