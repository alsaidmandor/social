
class PostModel {
  String name;
  String uId;
  String image;
  String text;
  String datetime;
  String postImage;


  PostModel({this.name, this.uId, this.image, this.text, this.datetime, this.postImage});

  PostModel.fromJson({Map<String, dynamic> json}) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
    datetime = json['datetime'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'datetime': datetime,
      'postImage': postImage,
    };
  }
}