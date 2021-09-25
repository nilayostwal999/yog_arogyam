import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'requestModel.dart';

class BookConsultation extends StatefulWidget {
  const BookConsultation();

  @override
  _BookConsultationState createState() => _BookConsultationState();
}

class _BookConsultationState extends State<BookConsultation> {
  RequestModel requestModel = new RequestModel();
  DateTime selectedDate = DateTime.now();
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Book a Consultation'),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Raise a request\nto get a callback\nfor booking the\nconsultation',
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w600, height: 1.25),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 80,
                ),
                RaisedButton(
                    onPressed: () async {
                      requestModel.email = globals.currentUser.email;
                      requestModel.firstName = globals.currentUser.firstName;
                      requestModel.lastName = globals.currentUser.lastName;
                      requestModel.mobile = globals.currentUser.mobile;
                      var requestMap = requestModel.toMap();
                      await db
                          .collection('requests')
                          .document(DateTime.now().toString())
                          .setData(requestMap);
                      // await showDialog(
                      //     context: context,
                      //     child: AlertDialog(
                      //       title: Text('Request Raised'),
                      //       content: Text(
                      //           'Your Request have been raised and soon you will get the callback to fix the meeting date and time.'),
                      //       actions: [
                      //         RaisedButton(
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //           child: Text('OK'),
                      //         )
                      //       ],
                      //     )).then((value) => Navigator.pop(context));
                    },
                    child: Text(
                      'Raise Request',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 180,
                ),
                (globals.currentUser.firstMeet)
                    ? Text(
                        'This is your First consultation\nhence it would be free',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )
                    : Text(' ')
              ],
            )));
  }
}
