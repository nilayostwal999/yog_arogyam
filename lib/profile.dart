import 'package:flutter/material.dart';
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
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.blue,

              ),

            ),
            SizedBox(height: 20,),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10.0,
                  ),
                  Text(
                    'aman.nagle1999@gmail.com',
                  ),

                ],
              ),
            ),
            SizedBox(height: 20.0),

            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle,
                        color:Colors.black),
                  SizedBox(width: 10.0),
                  Text(
                    'Aman Nagle',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.call,
                      color:Colors.black),
                  SizedBox(width: 10.0),
                  Text(
                    '9755029226',
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}

