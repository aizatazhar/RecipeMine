
class RecipeMiner{
  final String name;
  final String email;
  final String uid;
  final String profilePic;
  final List<dynamic> pantry;
  final List<dynamic> favourites;

  RecipeMiner({this.name, this.email, this.uid, this.profilePic, this.pantry, this.favourites});

  @override
  String toString() {
    return name + ' ' + email;
  }
}