class UserModel {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String uID;
  late String bio;
  late String image;
  late String cover;
  late bool isOnline;
  late bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.uID,
    required this.bio,
    required this.image,
    required this.cover,
    required this.isOnline,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    uID = json['uID'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    isOnline = json['isOnline'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uID': uID,
      'bio': bio,
      'image': image,
      'cover': cover,
      'isOnline': isOnline,
      'isEmailVerified': isEmailVerified,
    };
  }
}
