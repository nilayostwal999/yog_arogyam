import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailLoginController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 0.75,
            child: Image(image: AssetImage('assets/img/logo_title.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: passwordController,
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
                  Navigator.pushReplacementNamed(context, 'HomePage');
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
}
