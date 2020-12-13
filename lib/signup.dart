import 'package:flutter/material.dart';
import 'package:yog_arogyam/UserModel.dart';
import 'package:password/password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(padding: const EdgeInsets.all(16.0), child: MyCustomForm()),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  UserModel newUserModel = new UserModel();
  TextEditingController dateCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            height: 250.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/img/logo_title.png'))),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.firstName = value.trim();
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.lastName = value.trim();
            },
          ),
          TextFormField(
            controller: dateCtl,
            decoration: InputDecoration(
              labelText: "Date of birth",
              hintText: 'Date of Birth',
            ),
            onTap: () async {
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());

              date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));

              dateCtl.text = '${date.toLocal()}'.split(' ')[0];
            },
            onSaved: (value) {
              newUserModel.dob = dateCtl.text;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email Id'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.email = value.trim();
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mobile'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.mobile = value.trim();
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Country'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.country = value.trim();
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'State'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.state = value.trim();
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.city = value.trim();
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.password = Password.hash(value, new PBKDF2());
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // _formKey.currentState.validate();
                // Store user in Database
                _formKey.currentState.save();
                createUser().then((value) => {Navigator.of(context).pop()});
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future createUser() async {
    try {
      var userMap = newUserModel.toMap();
      final db = Firestore.instance;
      await db
          .collection("users")
          .document(newUserModel.email)
          .setData(userMap);

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: newUserModel.email,
        password: newUserModel.password,
      ))
          .user;
      user.sendEmailVerification().then((value) => print("Email Sent"));
      print(user.toString());
    } catch (err) {
      print(err.toString());
    }
  }
}
