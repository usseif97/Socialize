class StoryUserModel {
  late String name;
  late String uID;
  late String image;

  StoryUserModel({
    required this.name,
    required this.uID,
    required this.image,
  });

  StoryUserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uID = json['uID'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uID': uID,
      'image': image,
    };
  }
}
