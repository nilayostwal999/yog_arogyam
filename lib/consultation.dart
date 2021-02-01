import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'meetingmodel.dart';
import 'package:stripe_payment/stripe_payment.dart';

class BookConsultation extends StatefulWidget {
  @override
  _BookConsultationState createState() => _BookConsultationState();
}

class _BookConsultationState extends State<BookConsultation> {
  final db = Firestore.instance.collection("meetings");
  Token _paymentToken;
  String _error;
  MeetingModel meetingModel = new MeetingModel();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IFe1xEYpAi0hIb6WCZClm1R9toKbIupROboqUxwMA1pQPTcA7vnRR7SyrW12YIUky8LFDLMTbIej8MjnXcGu4Ri00bz4a1to7",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  DateTime selectedDate = DateTime.now();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Consultation'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              'Book an\nAvailable Slot',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            DecoratedBox(
              decoration: BoxDecoration(
                  border:
                      Border.all(style: BorderStyle.solid, color: Colors.grey)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(children: [
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    onPressed: () => _selectDate(context), // Refer step 3
                    child: Text(
                      'Select date',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                    color: Colors.blue,
                  ),
                ]),
              ),
            ),
            SizedBox(height: 40),
            FractionallySizedBox(
              widthFactor: .95,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.grey)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          'Select Time Slot',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  meetingModel.email =
                                      globals.currentUser.email;
                                  meetingModel.slot = '10:00';
                                  var meetMap = meetingModel.toMap();
                                  StripePayment.createTokenWithCard(
                                    testCard,
                                  ).then((token) {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Received ${token.tokenId}')));
                                    setState(() {
                                      _paymentToken = token;
                                    });
                                  }).then((value) => value
                                      ? db
                                          .document(selectedDate.toString())
                                          .collection('Slots')
                                          .document('10:00')
                                          .setData(meetMap)
                                      : Navigator.pop(context));
                                },
                                child: Text(
                                  '10:00 am',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '11:00 am',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '12:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '01:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '02:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '03:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '04:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '05:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  '06:00 pm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }
}
