import './controller/dao/Local.dart';
import './controller/dao/UserDAO.dart';
import './model/User.dart';
import './view/Support.dart';
import './view/dashboard.dart';
import 'package:flutter/material.dart';
import 'landing_page.dart';

User myUser;
Future main() async {
  await Local().getAllUsers().then((onValue) {
    onValue.forEach((val) {
      String username = val['username'];
      String pass = val['password'];
      String id = val['id'];
      print("HER>>>>>>>>>>>>>>>>");
      login(username, pass, id);
    });
    runApp(MyApp(false));
  });
  //runApp(MyApp(false));
}

void login(String username, String pass, String id) {
  print("onlogin");
  UserDAO().getUser(id: id).then((onValue) {
    User s = User.fromDocument(onValue);
    if (s.username == username && s.pass == pass) {
      myUser = s;
      runApp(MyApp(
        true,
      ));
    } else {
      runApp(MyApp(
        false,
      ));
    }
  }, onError: () {
    runApp(MyApp(
      false,
    ));
  });
}

class MyApp extends StatelessWidget {
  final bool login;

  const MyApp(this.login, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo
          //brightness: Brightness.dark,
          ),
      home: home(login),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

Widget home(bool login) {
  if (login)
    return DashboardMainPage();
  else
    return LandingPage();
}
