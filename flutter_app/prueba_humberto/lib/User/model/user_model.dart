class UserModel {
  String uid;
  String displayName;
  String email;
  String providerId;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.providerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'providerId': providerId,
    };
  }
}
