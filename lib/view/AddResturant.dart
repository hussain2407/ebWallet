import 'package:app/controller/dao/ResturantDAO.dart';
import 'package:app/model/Resturant.dart';
import 'package:app/view/Dashboard.dart';
import 'package:app/view/Support.dart';
import 'package:flutter/material.dart';

class AddResturant extends StatefulWidget {
  AddResturant({Key key}) : super(key: key);

  _AddResturantState createState() => _AddResturantState();
}

class _AddResturantState extends State<AddResturant> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();

  bool _isAdmin = false;

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: <Widget>[Text("Add New Restaurant "), Icon(Icons.face)],
        ),
      ),
      body: Card(
        elevation: 0,
        margin: EdgeInsets.all(30),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Restaurant Name"),
                  Card(
                    color: Colors.blueGrey[100],
                    child: Container(
                      child: TextField(
                        controller: _nameController,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Telephone No."),
                  Card(
                    color: Colors.blueGrey[100],
                    child: Container(
                      child: TextField(
                        controller: _telephoneController,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  checkValues();
                  //UserDAO().saveUser();
                }),
          ],
        ),
      ),
    );
  }

  bool hasValue(String val) {
    return (!(val == null || val.trim() == ""));
  }

  bool checkValues() {
    if (!Support.checkValues((_nameController.text)))
      showDialog(
        child: AlertDialog(
          title: Text("Enter name"),
          actions: <Widget>[Icon(Icons.error)],
        ),
        context: context,
      );
    else {
      ResturantDAO()
          .saveResturant(resturant: Resturant(name: _nameController.text))
          .get()
          .then((onValue) {
        showDialog(
          child: AlertDialog(
              title: Text(
            "Resturant Added",
          )),
          context: context,
        ).then((onValue) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
        });
      });
    }
  }
}
