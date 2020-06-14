import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipemine/Constants.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Home/FireBase/Database.dart';
import 'package:recipemine/pages/Home/Profile/Profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:recipemine/pages/LoadingScreen.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentProfilePic;
  String _buttonStatus = 'Update Profile';
  String _ProfilePicButtonStatus = 'Upload your new Profile Picture';
  bool _UpdateButtonDisabler = false;


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);


    Future getImage() async {
      setState(() {
        _UpdateButtonDisabler = true;
        _ProfilePicButtonStatus = 'Uploading...';
      });
      var image = await ImagePicker().getImage(source: ImageSource.gallery);
      String fileName = basename(image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask =  firebaseStorageRef.putFile(File(image.path));
      StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
      await FirebaseStorage.instance.ref().child(fileName).getDownloadURL().then((value){
        _currentProfilePic = value;
      });
      Future.delayed(Duration(seconds: 4));
      setState(() {
        _ProfilePicButtonStatus = "Updated!";
        _UpdateButtonDisabler = false;
      });

    }



    return StreamBuilder<RecipeMiner>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            RecipeMiner userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Update your Profile settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  Text('Update your Username',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        _ProfilePicButtonStatus,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await getImage();
                      }
                  ),
                  SizedBox(height:5),
                  Text(
                    'Please note that larger image files take a longer time to update, do wait until the button says that the picture has been uploaded before continuing',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        _buttonStatus,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(!_UpdateButtonDisabler) {
                          setState(() {
                            _buttonStatus = 'Updating....';
                          });
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? snapshot.data.name,
                                snapshot.data.email,
                                snapshot.data.uid,
                                _currentProfilePic,
                                snapshot.data.Pantry
                            );
                            Navigator.pop(context);
                          }
                        }
                      }
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}