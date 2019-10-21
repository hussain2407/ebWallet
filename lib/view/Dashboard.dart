import 'package:app/controller/dao/Local.dart';
import 'package:app/controller/dao/UserDAO.dart';
import 'package:app/main.dart';
import 'package:app/model/Constants.dart';
import 'package:app/model/User.dart';
import 'package:app/view/AddAdmin.dart';
import 'package:app/view/AddNewUser.dart';
import 'package:app/view/AddResturant.dart';
import 'package:app/view/ChooseToOrder.dart';
import 'package:app/view/RemoveUser.dart';
import 'package:app/view/Report.dart';
import 'package:app/view/SetDataToZero.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/settings_page.dart';
import 'PayCash.dart';

import 'package:app/pages/accounts_page.dart';
import 'package:app/pages/resturants_page.dart';
import '../main.dart';

class DashboardMainPage extends StatefulWidget {
  _DashboardMainPageState createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends State<DashboardMainPage> {
  List<User> data;
  @override
  void initState() {
    data = List();
    inti();
    super.initState();
  }

  void checkAdmin() {
    showDialog(
      child: AlertDialog(title: Text("You are not admin")),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // bottomNavigationBar: BottomAppBar(
        //   notchMargin: 10.0,
        //   child: Container(
        //     height: 60.0,
        //     color: Colors.black,
        //   ),
        // ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("---------------DASHBORD---------------");
            print(data);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (C)=>DashboardMainPage()));
            if (!myUser.admin)
              checkAdmin();
            else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (C) => ChooseToOrder(data),
                ),
              );
            }
          },
        ),
        //
        // THE DRAWER
        //
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('Cash to User'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => PayCash(data),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Add User'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (C) => AddNewUser(),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Add Admin'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (C) => AddAdmin(
                          data: data,
                        ),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Remove User'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (C) => RemoveUser(data),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Add Resturant'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (C) => AddResturant(),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Report'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (C) => Report(),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text('Restore Default Data'),
                onTap: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (C) => RestoreFactory(),
                      ),
                    );
                  }
                },
              ),
              // ListTile(
              //   title: Text('Add Order'),
              //   onTap: () {
              //     if (!myUser.admin)
              //       checkAdmin();
              //     else {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (C) => ChooseToOrder(data),
              //         ),
              //       );
              //     }
              //   },
              // ),
              // ListTile(
              //   title: Text('Settings'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (C) => RestoreFactory(),
              //       ),
              //     );
              //   },
              // ),
              // ListTile(
              //   title: Text('Logout'),
              //   onTap: () {
              //     Local().deleteUser(myUser.id).then((onValue) {
              //       if (onValue == 1) {
              //         myUser = null;
              //         Navigator.pushReplacement(context,
              //             MaterialPageRoute(builder: (C) => MyApp(false)));
              //       } else {
              //         showDialog(
              //           child: AlertDialog(title: Text("still login")),
              //           context: context,
              //         );
              //       }
              //     });
              //   },
              // ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Dashbord Main Page'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext conext) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.account_balance),
                text: 'Accounts',
              ),
              Tab(
                icon: Icon(Icons.restaurant),
                text: 'Restaurants',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AccountsPages(),
            ResturantsPages(),
          ],
        ),
      ),
    );
  }

  // FOR THE POPUP MENU
  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (C) => Settings(),
        ),
      );
    } else if (choice == Constants.SignOut) {
      Local().deleteUser(myUser.id).then((onValue) {
        if (onValue == 1) {
          myUser = null;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (C) => MyApp(false)));
        } else {
          showDialog(
            child: AlertDialog(title: Text("still login")),
            context: context,
          );
        }
      });
    }
  }

  void inti() async {
    data = null;
    data = List();
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
