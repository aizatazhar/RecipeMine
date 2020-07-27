import 'package:flappy_search_bar/flappy_search_bar.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:recipemine/AppStyle.dart';
import 'package:recipemine/Custom/Models/Recipe.dart';
import 'package:recipemine/Custom/Models/ReciperMinerUser.dart';
import 'package:recipemine/Custom/Models/User.dart';
import 'package:recipemine/pages/Authentication/Services/Auth.dart';
import 'package:recipemine/pages/Home/Community/ProfileBrowser.dart';

/// Builds the Community page.
class Community extends StatefulWidget {
  final Function onBeginCooking;

  Community({@required this.onBeginCooking});

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final users = Provider.of<List<RecipeMiner>>(context) ?? [];
    final currentUserUID = Provider.of<User>(context);
    List<Recipe> recipeList = Provider.of<List<Recipe>>(context) ?? [];

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

    /// Method for searching for a user.
    Future<List<RecipeMiner>> search(String input) async{
      // Search helper logic
      bool _searchHelper(String input, RecipeMiner element){
        if (input == 'all'){
          return true;
        }
        if (element.email.toLowerCase().contains(input.toLowerCase())){
          return true;
        }
        if (element.name.toLowerCase().contains(input.toLowerCase())){
          return true;
        }
        return false;
      }

      List<RecipeMiner> buffer = [];
      users.forEach((element) {
        if (_searchHelper(input, element)) {
          buffer.add(element);
        }
      });
      await Future.delayed(Duration(seconds: 1));
      return buffer;
    }

    // Prevents lag when transitioning.
    Future<Widget> buildPageAsync(RecipeMiner user) async {
      return Future.microtask(() {
        return ProfileBrowser(
          viewedUser: user,
          recipeList : recipeList,
          onBeginCooking: this.widget.onBeginCooking,
        );
      });
    }

    /// Builds a card given for a given user.
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
                    fit: BoxFit.cover,
                    width: 1000,
                    height: 1000,
                  ),
                ),
              ),
            ),
          ),
          title: Text(user.name),
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

          emptyWidget: _buildEmptyView(),
        )
      ),
    );
  }

  /// Builds the view when there are no users found.
  Widget _buildEmptyView() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppStyle.buildEmptyViewIcon(Icons.group),
            SizedBox(height: 20),
            Text(
              "No users found",
              style: AppStyle.mediumHeader,
            ),
            SizedBox(height: 10),
            Text(
              "Try searching for other users!",
              style: AppStyle.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}




