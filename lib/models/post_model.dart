class PostModel{
  String? name;
  String? uId;
  String? image;
  dynamic dateTime;
  String? text;
  String? postImage;
  List<String?>? likes=[];

  PostModel({this.name, this.uId, this.image,this.dateTime,this.text,this.postImage});

  PostModel.fromJson(Map<String, dynamic>? json,  likessss)
  {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];

    likessss.forEach((element){
      print('inside the constructor${element.id}');
      likes?.add(element.id);
    });


  }
  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };


  }
}