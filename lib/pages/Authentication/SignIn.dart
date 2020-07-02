import 'package:flutter/gestures.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/Loading.dart';
import 'package:recipemine/AppStyle.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  // Text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
      ? Loading()
      : _buildSignIn();
  }

  Widget _buildSignIn() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Welcome!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Sign in to continue",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 28,
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: AppStyle.signInAndRegisterDecoration.copyWith(
                      hintText: "email",
                      icon: Image.asset("assets/Sign In/user_icon.png"),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: AppStyle.signInAndRegisterDecoration.copyWith(
                      hintText: 'password',
                      icon: Image.asset("assets/Sign In/password_icon.png"),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter a password' : null,
                    onChanged: (val) {setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 50,
                    width: 1000,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      color: Colors.redAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 16,)
                        ],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()){
                          setState(() {loading = true;});

                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result is String) {
                            setState(() {
                              loading = false;
                              error = result;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan> [
                    TextSpan(
                      text: "Not signed up yet? ",
                      style: AppStyle.emptyViewCaption,
                    ),
                    TextSpan(
                      text: "Sign up",
                      style: AppStyle.clickableCaption,
                      recognizer: TapGestureRecognizer()..onTap = () => widget.toggleView(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


