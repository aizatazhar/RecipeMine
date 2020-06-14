// Class used for a registered recipeMiner
// All User-stored attributes will be parsed from firebase through this class.
// Enables us to use a User Object within our app.
class RecipeMinerProfile{
  final String name;
  final String emailAddress;

  RecipeMinerProfile({this.name, this.emailAddress});
}