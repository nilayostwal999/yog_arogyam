import 'package:flutter/material.dart';
import 'package:yog_arogyam/globals.dart' as globals;

class HistorySearch extends StatefulWidget {
  @override
  _HistorySearchState createState() => _HistorySearchState();
}

class _HistorySearchState extends State<HistorySearch> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
            addRepaintBoundaries: true,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: Image(image: AssetImage('assets/img/logo_title.jpg'))),
              ListTile(
                title: Text('Requests',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'AdminPageRequests', ModalRoute.withName('/'));
                },
              ),
              ListTile(
                title: Text('Meetings',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'AdminPageMeetings');
                },
              ),
              ListTile(
                title: Text('History',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'HistorySearch');
                },
              ),
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
        title: Text('Search History'),
      ),
      body: Container(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: 'Enter Mobile Number of User'),
                        )))
              ],
            ),
          ),
          RaisedButton(
            onPressed: () async {
              globals.mobile = searchController.text.trim();
              await Navigator.pushNamed(context, 'HistoryPage');
            },
            child: Text('Search'),
          )
        ]),
      ),
    );
  }
}
