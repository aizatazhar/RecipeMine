import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../AppStyle.dart';

/// Builds the password reset page.
class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  String email = '';
  final _formKey = GlobalKey<FormState>();
  FocusNode _emailNameFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isSendingEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Please enter your email to reset your password",
                  style: AppStyle.mediumHeader,
                ),
                SizedBox(height: 30),
                TextFormField(
                  focusNode: _emailNameFocusNode,
                  initialValue: '',
                  decoration: AppStyle.pantryInputDecoration.copyWith(
                    labelText: "Insert Email",
                    labelStyle: TextStyle(
                        color: _emailNameFocusNode.hasFocus
                            ? Colors.redAccent
                            : Colors.grey[700]
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter an email' : null,
                  onChanged: (val) => setState(() => email = val),
                ),
                SizedBox(height:30),
                _buildPasswordResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordResetButton(){
    return Container(
      height: 50,
      width: double.maxFinite,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.redAccent,
        child:
          Text(
            _isSendingEmail
                ? "Reset password"
                : "Resetting password....",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        onPressed: () async {
          setState(() {
            _isSendingEmail = false;
          });
          if (_formKey.currentState.validate()) {
            await auth.sendPasswordResetEmail(email: email);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
