import 'package:flutter/material.dart';
import 'main.dart';
import './controller/dao/Local.dart';
import './controller/dao/UserDAO.dart';
import './model/User.dart';
import './view/Support.dart';
import './view/dashboard.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          Column(
            children: <Widget>[
              Image.asset('assets/logo.png'),
              SizedBox(
                height: 20.0,
              ),
              //Text('ebWallet'),
            ],
          ),
          SizedBox(height: 120.0),
          TextField(
            controller: _username,
            decoration: InputDecoration(
              labelText: 'Username',
              filled: true,
            ),
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
            ),
            obscureText: true,
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  print(myUser);
                },
              ),
              RaisedButton(
                child: Text('OK'),
                onPressed: () {
                  UserDAO().getAllUsers().then((onval) {
                    onval.documents.forEach((data) {
                      User.fromDocument(data);
                    });
                  });
                  if (!Support.checkValues(_username.text)) {
                    showDialog(
                      child: AlertDialog(title: Text("insert Username please")),
                      context: context,
                    );
                  } else if (!Support.checkValues(_password.text)) {
                    showDialog(
                      child: AlertDialog(title: Text("insert password please")),
                      context: context,
                    );
                  } else
                    UserDAO()
                        .getUserByUsernameAndPass(
                          username: _username.text,
                        )
                        .getDocuments()
                        .then((onValue) {
                      if (onValue.documents.length != 0)
                        onValue.documents.forEach((doc) {
                          User s = User.fromDocument(doc);
                          print(s);
                          if (_password.text == s.pass) {
                            myUser = s;
                            print(myUser);
                            Local().saveUser(
                                id: myUser.id,
                                pass: myUser.pass,
                                username: myUser.username);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (C) => DashboardMainPage()));
                          } else {
                            showDialog(
                              child: AlertDialog(
                                  title:
                                      Text("username or password Not valid ")),
                              context: context,
                            );
                          }
                        });
                      else {
                        showDialog(
                          child: AlertDialog(
                              title: Text("username or password Not valid ")),
                          context: context,
                        );
                      }
                    });
                },
              )
            ],
          )
        ],
      ),
    ));
  }
}
