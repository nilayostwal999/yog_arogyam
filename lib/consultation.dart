import 'package:flutter/material.dart';

class BookConsultation extends StatefulWidget {
  @override
  _BookConsultationState createState() => _BookConsultationState();
}

class _BookConsultationState extends State<BookConsultation> {
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
                                onPressed: () {},
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
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Make Payment',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              color: Colors.blue,
            )
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
