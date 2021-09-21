class SocialChatModel
{
  String senderId,receiverId,dateTime,text,receiverToken,image;

  SocialChatModel({this.dateTime,this.text,this.receiverId,this.senderId,this.receiverToken,this.image});

  SocialChatModel.fromJson(Map <String,dynamic> json)
  {
    senderId =json['senderId'];
    receiverId =json['receiverId'];
    receiverToken=json['receiverToken'];
    dateTime =json['dateTime'];
    text =json['text'];
    image=json['image'];

  }

  Map <String,dynamic> toMap()
  {
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'text':text,
      'dateTime':dateTime,
      'receiverToken':receiverToken,
      'image':image
      };
  }

}