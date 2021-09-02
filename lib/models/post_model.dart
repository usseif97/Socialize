class PostModel {
  late String name;
  late String uID;
  late String image;
  late String date;
  late String postText;
  late String postImage;

  PostModel({
    required this.name,
    required this.uID,
    required this.image,
    required this.date,
    required this.postText,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uID = json['uID'];
    image = json['image'];
    date = json['date'];
    postText = json['postText'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uID': uID,
      'image': image,
      'date': date,
      'postText': postText,
      'postImage': postImage,
    };
  }
}
