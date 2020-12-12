import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yog_arogyam/globals.dart' as globals;
import 'package:yog_arogyam/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';

import 'UserModel.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 0.7,
            child: Image(image: AssetImage('assets/img/logo_title.png')),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.person), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailLoginController,
                          decoration: InputDecoration(hintText: 'Email'),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: passwordLoginController,
                          decoration: InputDecoration(hintText: 'Password'),
                          obscureText: true,
                        ))),
              ],
            ),
          ),
          FractionallySizedBox(
              widthFactor: 1 / 4,
              child: RaisedButton(
                onPressed: () {
                  getData(emailLoginController.text.trim()).then((userDoc) => {
                        loginUser()

                        //   if (userDoc.data["password"] ==
                        //       passwordLoginController.text)
                        //     {onSuccess(userDoc.data)}
                        //   else
                        //     {
                        //       showDialog(
                        //         context: context,
                        //         builder: (context) {
                        //           return AlertDialog(
                        //             content: Text("Password Incorrect"),
                        //           );
                        //         },
                        //       )
                        //     }
                      });
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                padding: EdgeInsets.all(5),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 10, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Doesn\'t have an account?\nMake One',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'SignUp');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 19,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )),
          Text(
            "Made In India",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.orange[600],
                fontWeight: FontWeight.bold),
          ),
          Text(
            "With 💙",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.blue[800],
                fontWeight: FontWeight.bold),
          ),
          Text(
            "For The World",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.green[700],
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  getData(String uid) async {
    final usersCollectionRef = Firestore.instance.collection("users");
    return usersCollectionRef.document(uid).get();
  }

  onSuccess(userDataMap) async {
    // Directory dir = await getApplicationDocumentsDirectory();
    // String path = dir.path + "current_user.json";

    // File loggedInUserFile = new File(path);
    // // print(userDataObj);
    // loggedInUserFile.writeAsStringSync(jsonEncode(userDataMap));
    globals.currentUser = UserModel.toObject(userDataMap);
    Navigator.pushReplacementNamed(context, 'HomePage');
  }

  loginUser() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: emailLoginController.text.trim(),
              password:
                  Password.hash(passwordLoginController.text, new PBKDF2())
                      .toString()))
          .user;
      if (user.isEmailVerified) {
        Firestore db = Firestore.instance;
        DocumentSnapshot userSnapshot =
            await db.collection("users").document(user.email).get();
        UserModel loggedInUser = UserModel.toObject(userSnapshot);
        globals.currentUser = loggedInUser;
        onSuccess(userSnapshot);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password Incorrect or User Not Verified"),
            );
          },
        );
      }
    } catch (err) {
      print(err);
    }
  }
}
