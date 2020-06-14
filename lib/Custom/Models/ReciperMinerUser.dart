
class RecipeMiner{
  final String name;
  final String email;
  final String uid;
  final String profilePic;
  final List<String> pantry;

  RecipeMiner({this.name, this.email, this.uid, this.profilePic, this.pantry});

  @override
  String toString() {
    return name + ' ' + email;
  }
}