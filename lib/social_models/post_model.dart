class SocialPostModel
{
  String name,uId,image,postText,dateTime;
  List postImage;
  SocialPostModel({this.uId,this.name,this.image,this.postImage,this.postText,this.dateTime});

  SocialPostModel.fromJson(Map <String,dynamic> json)
  {
    name =json['name'];
    postImage =json['postImage'];
    postText =json['postText'];
    uId =json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];

  }

  Map <String,dynamic> toMap()
  {
    return {
      'name':name,
      'postText':postText,
      'postImage':postImage,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,

    };
  }

}

