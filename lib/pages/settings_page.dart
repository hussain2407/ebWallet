import 'package:flutter/material.dart';
import 'package:app/view/PayCash.dart';
import 'package:app/ui/widgets/common_scaffold.dart';
import 'package:app/ui/widgets/common_switch.dart';
import 'package:app/utils/uidata.dart';

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
import 'package:app/pages/settings_page.dart';
import 'package:app/pages/accounts_page.dart';
import 'package:app/pages/resturants_page.dart';
import 'package:app/main.dart';

class Settings extends StatelessWidget {
  Widget bodyData() => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Users Setting",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      title: Text("Add User"),
                      trailing: Icon(Icons.arrow_right),
                      // onTap: () {
                      //   if (!myUser.admin)
                      //     checkAdmin();
                      //   else {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (C) => AddNewUser(),
                      //       ),
                      //     );
                      //   }
                      // },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                      title: Text("Remove User"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: Text("Add Administrator"),
                      trailing: Icon(Icons.arrow_right),
                    )
                  ],
                ),
              ),

              //2
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Reports",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.sim_card,
                        color: Colors.grey,
                      ),
                      title: Text("Reports"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                ),
              ),

              //3
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Administration",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.sync,
                        color: Colors.green,
                      ),
                      title: Text("Restore Database"),
                      trailing: Icon(Icons.arrow_right),
                      // onTap: () {
                      //   if (!myUser.admin)
                      //     checkAdmin();
                      //   else {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (C) => RestoreFactory(),
                      //       ),
                      //     );
                      //   }
                      // },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Settings",
      showDrawer: false,
      showFAB: false,
      backGroundColor: Colors.grey.shade300,
      bodyData: bodyData(),
    );
  }
}

// void checkAdmin() {
//   showDialog(
//     child: AlertDialog(title: Text("You are not admin")),
//     context: context,
//   );
// }
