import 'package:app/ui/pages/auth/login.dart';
import 'package:app/ui/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  bool shpwSpinner = false;
  String _email;

  String _password;

  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBg,
      body: ModalProgressHUD(
        inAsyncCall: shpwSpinner,
              child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0), color: Colors.white),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Full Name",
                  style: smallText,
                ),
                _buildTextField(),
                const SizedBox(height: 20.0),
                Text(
                  "Mobile Number",
                  style: smallText,
                ),
                _buildTextField(),
                const SizedBox(height: 20.0),
                Text(
                  "Email",
                  style: smallText,
                ),
                TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Password",
                  style: smallText,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Confirm Password",
                  style: smallText,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  "By signing up you agree to the Terms & Conditions",
                  style: smallText,
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text("Sign Up".toUpperCase()),
                      onPressed: () async {
                        setState(() {
                          shpwSpinner = true;
                        });
                        //  print(_email);
                        //  print(_password);
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _email, password: _password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, HomePage.id);
                         }
                         setState(() {
                           shpwSpinner = false;
                         });
                        } catch (e) {
                          print(e);
                          setState(() {
                            shpwSpinner = false;
                          });
                        }
                      },
                    )),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: Colors.grey.shade600,
                    )),
                    const SizedBox(width: 10.0),
                    Text(
                      "Already have an account?",
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
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Login".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.id, (Route<dynamic> route) => false),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
    );
  }
}
