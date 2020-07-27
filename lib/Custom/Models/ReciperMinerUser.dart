
/// Models a user.
class RecipeMiner{
  final String name;
  final String user;
  final String email;
  final String uid;
  final String profilePic;
  final List<dynamic> pantry;
  final List<dynamic> favourites;

  RecipeMiner({this.name,this.user,this.email, this.uid, this.profilePic, this.pantry, this.favourites});

  @override
  String toString() {
    return name + ' ' + email;
  }
}