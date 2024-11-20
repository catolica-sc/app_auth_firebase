class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  UserModel({required this.uid, required this.displayName, required this.email, this.photoURL});
}