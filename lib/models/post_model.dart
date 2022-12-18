class PostModel{
  String? name;
  String? uId;
  String? image;
  dynamic dateTime;
  String? text;
  String? postImage;
  List<String?>? likes=[];
  List<CommentsModel> comments = [];

  PostModel({this.name, this.uId, this.image,this.dateTime,this.text,this.postImage});

  PostModel.fromJson(Map<String, dynamic>? json,  likessss, comment)
  {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];

    likessss.forEach((element){
      // print('inside the constructor${element.id}');
      likes?.add(element.id);
    });

    // comment.forEach((element) {
    //   // print('inside the comment ${element}');
    //   comments.add(CommentsModel.fromJson(element));
    // });


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

class CommentsModel{
  String? postId;
  String? comment;
  dynamic dateTime;
  String? userId;

  CommentsModel(this.postId, this.comment, this.dateTime, this.userId);
  CommentsModel.fromJson(Map<String, dynamic> json)
  {
    postId = json['postId'];
    comment = json['comment'];
    dateTime = json['dateTime'];
    userId = json['userId'];
  }
  Map<String, dynamic> toMap()
  {
    return{
      'postId':postId,
      'comment':comment,
      'dateTime':dateTime,
      'userId':userId,
    };
  }

}