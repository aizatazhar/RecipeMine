import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/AppStyle.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:recipemine/pages/Home/Community/ProfileBrowser.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);

    // contains the current user details
    RecipeMiner currentUserData = RecipeMiner(
        name:'Loading',
        email: 'Loading',
        uid: 'Loading',
        profilePic: 'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg'
    );

    users.forEach((element) {
      if (element.uid == currentUserUID.uid){
        currentUserData = element;
      }
    });

    // SearchEngine logic
    bool searchEngine(String input, RecipeMiner element){
      if (input == 'all'){
        return true;
      }

      if (element.email == currentUserData.email){
        return false;
      }

      if (element.email.toLowerCase().contains(input.toLowerCase())){
        return true;
      }

      if (element.name.toLowerCase().contains(input.toLowerCase())){
        return true;
      }

      return false;
    }

    // method for searching
    Future<List<RecipeMiner>> search(String input) async{
      List<RecipeMiner> buffer = [];
      users.forEach((element) {
        if (searchEngine(input,element)) {
          buffer.add(element);
        }
      });
      await Future.delayed(Duration(seconds: 1));
      return buffer;
    }

    // prevent lag when transition
    Future<Widget> buildPageAsync(RecipeMiner user) async {
      return Future.microtask(() {
        return ProfileBrowser(viewedUser: user);
      });
    }

    // method onfound
    Widget whenFound(RecipeMiner user, int index){
      return Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Container(
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.pink,
              child: ClipOval(
                child: new SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Image.network(
                    user.profilePic,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () async {
              var page = await buildPageAsync(user);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => page));
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: SearchBar<RecipeMiner>(
          hintText: "Search for other users",
          hintStyle: AppStyle.searchBarHintStyle,

          iconActiveColor: Colors.redAccent,
          searchBarPadding: EdgeInsets.symmetric(horizontal: 20.0),
          searchBarStyle: AppStyle.searchBarStyle,

          onSearch: search,
          onItemFound: whenFound,
        )
      ),
    );
  }
}




