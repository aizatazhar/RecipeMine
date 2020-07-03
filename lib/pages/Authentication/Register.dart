import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/Loading.dart';
import '../../AppStyle.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Used to change color of label text and show clear icon when in focus
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  // Used to clear input and to validate password during registration
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _clearIconSize = 20.0;

  String error = '';
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : _buildRegister();
  }

  Widget _buildRegister() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            widget.toggleView();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(),
                SizedBox(height: 30),
                _buildForms(),
                SizedBox(height: 30),
                _buildSignUpButton(),
                SizedBox(height: 20),
                _buildErrorMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
        "Create a new account",
        style: AppStyle.largeHeader
    );
  }

  Widget _buildForms() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            onTap: () {
              setState(() {FocusScope.of(context).requestFocus(_emailFocusNode);});
            },

            validator: (val) => val.isEmpty ? 'Enter an email' : null,
            onChanged: (val) => setState(() => email = val),

            decoration: AppStyle.registerDecoration.copyWith(
              // At the time of writing this, there is a bug that will
              // only show the hint and suffix upon focus, this has been
              // fixed in a very recent PR and will be available shortly.
              // See GitHub issue https://github.com/flutter/flutter/pull/60394
              hintText: 'name@example.com',
              labelText: "Email",
              labelStyle: TextStyle(color: _emailFocusNode.hasFocus ? Colors.redAccent : Colors.grey[700]),
              suffixIcon: _emailFocusNode.hasFocus && _emailController.text.length > 0
                  ? _buildClearButton(_emailController)
                  : null,
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            onTap: () {
              setState(() {FocusScope.of(context).requestFocus(_passwordFocusNode);});
            },

            obscureText: true,
            validator: (val) => val.length < 6 ? 'Password must be at least 6 characters' : null,
            onChanged: (val) => setState(() => password = val),

            decoration: AppStyle.registerDecoration.copyWith(
              hintText: 'Enter a password',
              labelText: "Password",
              labelStyle: TextStyle(color: _passwordFocusNode.hasFocus ? Colors.redAccent : Colors.grey[700]),
              suffixIcon: _passwordFocusNode.hasFocus && _passwordController.text.length > 0
                  ? _buildClearButton(_passwordController)
                  : null,
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            focusNode: _confirmPasswordFocusNode,
            controller: _confirmPasswordController,
            onTap: () {
              setState(() {FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);});
            },

            obscureText: true,
            validator: (val) => val != _passwordController.text ? "Passwords do not match" : null,
            onChanged: (val) => {setState(() {})},

            decoration: AppStyle.registerDecoration.copyWith(
              hintText: 'Enter your password again',
              labelText: "Confirm password",
              labelStyle: TextStyle(color: _confirmPasswordFocusNode.hasFocus ? Colors.redAccent : Colors.grey[700]),
              suffixIcon: _confirmPasswordFocusNode.hasFocus && _confirmPasswordController.text.length > 0
                  ? _buildClearButton(_confirmPasswordController)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearButton(TextEditingController controller) {
    return IconButton(
      onPressed: () => controller.clear(),
      icon: Icon(
        Icons.clear,
        size: _clearIconSize,
        color: Colors.redAccent,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      height: 50,
      width: double.maxFinite,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.redAccent,
        child: Text(
          "Sign up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() {
              loading = true;
            });
            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
            if (result is String) {
              setState(() {
                loading = false;
                error = result;
              });
            }
          }
        },
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );
  }
}

