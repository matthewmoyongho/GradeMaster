class User {
  String? username;
  String email;
  String? phone;
  double? gpTarget;
  String? school;
  String? imageURL;
  User(
      {this.username,
      required this.email,
      this.phone,
      this.gpTarget,
      this.school,
      this.imageURL});
}
