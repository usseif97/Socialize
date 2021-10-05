/*enum MediaType {
  image,
  video,
}*/

class StoryModel {
  late String url;
  late String media;
  late int duration;
  late String userName;
  late String userImage;
  late String date;

  StoryModel({
    required this.url,
    required this.media,
    required this.duration,
    required this.userName,
    required this.userImage,
    required this.date,
  });

  StoryModel.fromJson(Map<String, dynamic>? json) {
    url = json!['url'];
    media = json['media'];
    duration = json['duration'];
    userName = json['userName'];
    userImage = json['userImage'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'media': media,
      'duration': duration,
      'userName': userName,
      'userImage': userImage,
      'date': date
    };
  }
}
