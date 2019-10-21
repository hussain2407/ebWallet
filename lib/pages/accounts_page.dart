import '../controller/dao/UserDAO.dart';
import '../main.dart';
import '../model/User.dart';
import '../view/AddAdmin.dart';
import '../view/AddNewUser.dart';
import '../view/AddResturant.dart';
import '../view/ChooseToOrder.dart';
import '../view/RemoveUser.dart';
import '../view/Report.dart';
import '../view/SetDataToZero.dart';
import 'package:flutter/material.dart';
import '../view/PayCash.dart';

class AccountsPages extends StatefulWidget {
  AccountsPages({Key key}) : super(key: key);

  _AccountsPagesState createState() => _AccountsPagesState();
}

class _AccountsPagesState extends State<AccountsPages> {
  List<User> data = List();

  @override
  void initState() {
    inti();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (c, i) => itemBuilder(i),
            itemCount: data.length,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          isThreeLine: false,
          enabled: true,
          title: Text(data[index].firstName + " " + data[index].lastName),
          trailing: Text("${data[index].amount.toStringAsFixed(2)}"),
          leading: CircleAvatar(
            maxRadius: 25,
            child: Text(
              "" +
                  data[index].firstName.substring(0, 1).toUpperCase() +
                  data[index].lastName.substring(0, 1).toUpperCase(),
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Divider()
      ],
    );
  }

  void inti() async {
    UserDAO().getAllUsers().then((onValue) {
      onValue.documents.forEach((doc) {
        if (mounted)
          setState(() {
            data.add(
              User.fromDocument(doc),
            );
          });
      });
    });
  }
}
