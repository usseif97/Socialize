class CommentModel {
  late String name;
  late String uID;
  late String image;
  late String comment;

  CommentModel({
    required this.name,
    required this.uID,
    required this.image,
    required this.comment,
  });

  CommentModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uID = json['uID'];
    image = json['image'];
    comment = json['comment'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uID': uID,
      'image': image,
      'comment': comment,
    };
  }
}
