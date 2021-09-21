class SocialUserModel
{
  String name,email,phone,uId,image,bio,cover;
  bool isEmailVerified;
  SocialUserModel({this.uId,this.email,this.phone,this.name,this.isEmailVerified,this.image,this.bio,this.cover});

  SocialUserModel.fromJson(Map <String,dynamic> json)
  {
    name =json['name'];
    phone =json['phone'];
    email =json['email'];
    uId =json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map <String,dynamic> toMap()
  {
    return {
        'name':name,
        'phone':phone,
        'email':email,
        'uId':uId,
    'isEmailVerified':isEmailVerified,
      'image':image,
      'cover':cover,
      'bio':bio,
      };
  }

}