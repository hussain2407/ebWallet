import 'package:app/ui/pages/auth/recover.dart';
import 'package:app/ui/pages/auth/register.dart';
import 'package:app/ui/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:app/res/colors.dart';
//import 'package:app/res/constants.dart';
import 'package:app/res/typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBg,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              top: 10, left: 16.0, right: 16.0, bottom: 10.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 70),
                padding:
                    const EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.perm_contact_calendar),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: "Mobile or Email"),
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.lock),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: GestureDetector(
                                    child: Icon(Icons.remove_red_eye),
                                    onTap: () {},
                                  )),
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        width: double.infinity,
                        child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text("Login".toUpperCase()),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.pushNamed(context, HomePage.id);
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        child: Text(
                          "Forgot Password".toUpperCase(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RecoverPasswordPage.id);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: Colors.grey.shade600,
                          )),
                          const SizedBox(width: 10.0),
                          Text(
                            "Not a member?",
                            style: smallText,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: Divider(
                            color: Colors.grey.shade600,
                          )),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        child: Text(
                          "Create Account".toUpperCase(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
              // Container(
              //     margin: const EdgeInsets.only(top: 20.0),
              //     alignment: Alignment.center,
              //     height: 100,
              //     child: Image.asset(
              //       "assets/logo.png",
              //       fit: BoxFit.contain,
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
