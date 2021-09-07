class LikeModel {
  late String name;
  late String uID;
  late String image;
  late bool like;

  LikeModel({
    required this.name,
    required this.uID,
    required this.image,
    required this.like,
  });

  LikeModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uID = json['uID'];
    image = json['image'];
    like = json['like'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uID': uID,
      'image': image,
      'like': like,
    };
  }
}
