import 'package:flutter/material.dart';
import 'package:yog_arogyam/drawer.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: DrawerButton()),
        appBar: AppBar(
          elevation: 20,
          title: Text(
            'Yog Arogyam',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
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
