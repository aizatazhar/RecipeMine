import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/CustomWidgets/SecondaryButton.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:recipemine/pages/Authentication/Services/PasswordReset.dart';
import 'package:recipemine/pages/Loading.dart';
import 'package:recipemine/AppStyle.dart';

/// Builds the sign in page.
class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Used to change color of label text and show clear icon when in focus
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  // Used to clear input and to validate password during registration
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _clearIconSize = 20.0;

  bool loading = false;
  String error = '';

  // Text field state
  String email = '';
  String password = '';

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(),
                SizedBox(height: 30),
                _buildForms(),
                SizedBox(height: 30),
                _buildSignInButton(),
                SizedBox(height: 10),
                _buildSignUpButton(),
                SizedBox(height: 20),
                _buildErrorMessage(),
                _buildPasswordReset(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordReset(){
    return Center(
      child: FlatButton(
        child: Text(
            'Forgot password?',
            style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            fontSize: 16,
            )),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => PasswordReset()
          ));
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Welcome!",
          style: AppStyle.largeHeader,
        ),
        SizedBox(height: 10),
        Text(
            "Sign in to continue",
            style: AppStyle.caption
        ),
      ],
    );
  }

  Widget _buildForms() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: Key("email"),
            controller: _emailController,
            focusNode: _emailFocusNode,
            onTap: () {
              setState(() {FocusScope.of(context).requestFocus(_emailFocusNode);});
            },
            decoration: AppStyle.signInDecoration.copyWith(
              hintText: "name@example.com",
              icon: Image.asset("assets/Sign In/user_icon.png"),
              suffixIcon: _emailFocusNode.hasFocus && _emailController.text.length > 0
                  ? _buildClearButton(_emailController)
                  : null,
            ),
            validator: emailValidator,
            onChanged: (val) => setState(() => email = val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            key: Key("password"),
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            onTap: () {
              setState(() {FocusScope.of(context).requestFocus(_passwordFocusNode);});
            },
            obscureText: true,
            decoration: AppStyle.signInDecoration.copyWith(
              hintText: 'Enter your password',
              icon: Image.asset("assets/Sign In/password_icon.png"),
              suffixIcon: _passwordFocusNode.hasFocus && _passwordController.text.length > 0
                  ? _buildClearButton(_passwordController)
                  : null,
            ),
            validator: passwordValidator,
            onChanged: (val) => setState(() => password = val),
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

  Widget _buildSignInButton() {
    return MainButton(
      key: Key("signIn"),
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
      width: double.maxFinite,
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
    );
  }

  Widget _buildSignUpButton() {
    return SecondaryButton(
      child: RichText(
        text: TextSpan(
          children: <TextSpan> [
            TextSpan(
              text: "Not signed up yet? ",
              style: AppStyle.caption,
            ),
            TextSpan(
              text: "Sign up",
              style: AppStyle.clickableCaption,
            )
          ],
        ),
      ),
      width: double.maxFinite,
      onPressed: () async {
        widget.toggleView();
      },
    );
  }

  Widget _buildErrorMessage() {
    return Center(
      child: Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 16.0),
      )
    );
  }
}

// Extracted methods to enable unit testing
String emailValidator(String string) {
  return string.isEmpty ? "Enter an email" : null;
}

String passwordValidator(String string) {
  return string.isEmpty ? "Enter a password" : null;
}
