import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/Custom/CustomWidgets/MainButton.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:recipemine/pages/Loading.dart';
import 'package:recipemine/AppStyle.dart';

/// Builds the page for users to edit their profile.
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentProfilePic;

  FocusNode _usernameFocusNode = FocusNode(); // change color of label text when in focus

  bool _uploaded = false; // to update upload button ui

  bool _saving = false; // to update save profile button ui
  bool _saveButtonPressed = false; // ensures user can only press save once
  bool _saveDisabled = false; // prevent user from saving when profile picture is uploading

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

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

      body: StreamBuilder<RecipeMiner>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }

          RecipeMiner userData = snapshot.data;

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeader(),
                    SizedBox(height: 30),
                    _buildUploadProfilePictureButton(),
                    SizedBox(height: 20.0),
                    TextFormField(
                      focusNode: _usernameFocusNode,
                      initialValue: userData.name,
                      decoration: AppStyle.pantryInputDecoration.copyWith(
                        labelText: "New username",
                        labelStyle: TextStyle(
                          color: _usernameFocusNode.hasFocus
                              ? Colors.redAccent
                              : Colors.grey[700]
                        ),
                      ),
                      validator: usernameValidator,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 30.0),
                    _buildSaveButton(context, user, snapshot),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Update your profile',
      style: AppStyle.mediumHeader,
    );
  }

  Widget _buildUploadProfilePictureButton() {
    return RaisedButton(
      child: Text(
        _uploaded ? "Profile picture uploaded!" : "Upload profile picture",
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 0.5),
      ),
      onPressed: () async {
        await _getImage();
        setState(() {
          _uploaded = true;
        });
      },
    );
  }

  Future _getImage() async {
    _saveDisabled = true;

    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );

    String fileName = basename(image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    await FirebaseStorage.instance
        .ref()
        .child(fileName)
        .getDownloadURL()
        .then((value) {
      _currentProfilePic = value;
    });

    _saveDisabled = false;
  }

  Widget _buildSaveButton(BuildContext context, User user, AsyncSnapshot<RecipeMiner> snapshot) {
    return MainButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _saving ? "Saving..." : "Save profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      width: double.maxFinite,
      onPressed: () async {
        if (!_saveButtonPressed && !_saveDisabled) {
          if (_formKey.currentState.validate()) {
            _saving = true;
            _saveButtonPressed = true;

            await DatabaseService(uid: user.uid).updateUserData(
              _currentName ?? snapshot.data.name,
              snapshot.data.email,
              snapshot.data.uid,
              _currentProfilePic,
              snapshot.data.pantry,
              snapshot.data.favourites,
            );

            Navigator.pop(context);
          }
        }
      },
    );
  }
}

String usernameValidator(String string) {
  return string.isEmpty ? 'Please enter a username' : null;
}
