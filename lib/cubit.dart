import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/post/post_screen.dart';
import 'package:social_app/settings/settings_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/social_models/chat_model.dart';
import 'package:social_app/social_models/post_model.dart';
import 'package:social_app/social_models/social_user_model.dart';
import 'package:social_app/states.dart';
import 'package:social_app/users/users_screen.dart';

import 'chats/chats_screen.dart';
import 'feeds/feeds_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;

  void getUserData() {
    emit(SocialLoadingState());
    uId = CacheHelper.getData(key: 'uId');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }

  List<Widget> socialScreens =
  [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingScreen()
  ];

  List<String> titles = ['facebook', 'Chats', 'Post', 'Users', 'Settings'];
  int currentIndex = 0;

  void changeBottomNav(int index) {

    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
    if(index==1)
    {
      if(users.length==0  )getUsers();
    }
  }


  File profileImage;
  var picker = ImagePicker();

  Future <void> getProfileImage() async //
      {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfilePickedSuccessState());
    }
    else {
      emit(SocialProfilePickedErrorState());
      print('no Image selected');
    }
  }

  File coverImage;

  Future <void> getCoverImage() async //
      {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverPickedSuccessState());
    }
    else {
      emit(SocialCoverPickedErrorState());
      print('no Image selected');
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    @required String name,
    @required String bio,
    @required String phone,

  }) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage.path)
        .pathSegments
        .last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        profileImageUrl = value;
        updateUserData(name: name, bio: bio, phone: phone, image: value);
        emit(SocialUploadProfileSuccessState());
      })
          .catchError((onError) {
        emit(SocialUploadProfileErrorState());
      });
    })
        .catchError((onError) {
      emit(SocialUploadProfileErrorState());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage({
    @required String name,
    @required String bio,
    @required String phone,

  }) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage.path)
        .pathSegments
        .last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        emit(SocialUploadCoverSuccessState());
        coverImageUrl = value;
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      })
          .catchError((onError) {
        emit(SocialUploadCoverErrorState());
      });
    })
        .catchError((onError) {
      emit(SocialUploadCoverErrorState());
    });
  }

  void updateUserImages({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(SocialUpdateLoadingState());
    if (coverImage != null) {
      uploadCoverImage();
    }
    else if (profileImage != null) {
      uploadProfileImage();
    }
    else if (coverImage != null && profileImage != null) {

    }
    else
      updateUserData(name: name, bio: bio, phone: phone);
  }

  void updateUserData({
    @required String name,
    @required String bio,
    @required String phone,
    String cover,
    String image,
  }) {
    emit(SocialUpdateLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      email: userModel.email,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      uId: userModel.uId,
      isEmailVerified: false,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(SocialUpdateSuccessState());
    })
        .catchError((onError) {
      emit(SocialUpdateErrorState());
    });
  }


  File postImage;
  List<File> postImages=[];

  Future <void> getPostImage() async //
      {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      postImages.add(postImage);
      emit(SocialPostImagePickedSuccessState());
    }
    else {
      emit(SocialPostImagePickedErrorState());
      print('no Image selected');
    }
  }

  void removePostImage(int index) {
    postImages.removeAt(index);
    emit(SocialRemovePickedState());
  }


  List<String> postImgUrl=[];
  void uploadPostImage({
    @required String postText,
    @required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    for(int i=0;i<=postImages.length;i++)
    {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts/${Uri
          .file(postImages[i].path)
          .pathSegments
          .last}')
          .putFile(postImages[i])
          .then((value) {
        value.ref.getDownloadURL()
            .then((value) {
           postImgUrl.add(value);
           if(i==postImages.length-1)
              createNewPost(postText: postText, dateTime: dateTime, postImage: postImgUrl);

        })
            .catchError((onError) {
          emit(SocialCreatePostErrorState());
        });
      }).then((value)
      {
        emit(SocialUploadCoverSuccessState());
      })
          .catchError((onError) {
        emit(SocialCreatePostErrorState());
      });
    }


  }

  void createNewPost({
    @required String postText,
    @required String dateTime,
    List postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    SocialPostModel model = SocialPostModel(
        image: userModel.image,
        name: userModel.name,
        postText: postText,
        dateTime: dateTime,
        uId: uId,
        postImage: postImage?? []
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    })
        .catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  List <SocialPostModel> posts = [];
  List <String> postsId = [];
  List <String> postsuId = [];
  List <String> POSTUID=[];
  List <int> likes = [];
  List <IconData> likeIcon=[];
  bool currentLike;


  void getPosts() {
    emit(SocialGetPostsLoadingState());
    int i=0;
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      posts=[];
      event.docs.forEach((element) {
        element.reference
            .collection('likes')
            .get()
            .then((value) {
          likeIcon.add(Icons.favorite_outline_outlined);
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
          getLikes(postsId[i],i);
          i++;
          emit(SocialGetPostsSuccessState());
        });
      });
    });
  }

  void likePosts(String postId,index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true})
        .then((value) {
      currentLike=true;
      likeIcon[index]=Icons.favorite;
      emit(SocialLikePostsSuccessState());
    })
        .catchError((onError) {
      emit(SocialLikePostsErrorState(onError.toString()));
    });
  }

  void disLikePosts(String postId,index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .delete()
        .then((value) {
      currentLike=false;
      likeIcon[index]=Icons.favorite_outline;
      emit(SocialDisLikePostsSuccessState());
    })
        .catchError((onError) {
      emit(SocialDisLikePostsErrorState(onError.toString()));
    });
  }

  void getLikes(String postId,int index)
  {
    print('x');
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value){
      value.docs.forEach((element) {
        postsuId.add(element.id);

        });

      for(var i in postsuId)
      {
        if(uId == i)
        {
          print(i);
          currentLike=true;
          likeIcon[index]=Icons.favorite;
        }
        else
        {
          currentLike=false;
          likeIcon[index]=Icons.favorite_outline_outlined;
        }
      }
      emit(SocialGetLikePostsSuccessState());
    }).catchError((onError){});


  }

  void writeComment({
    @required String postId,
    @required String comment,
    @required String dateTime,
    @required String text,
  }) {

    SocialChatModel model=SocialChatModel(
        text: text,
        senderId:userModel.uId ,
        dateTime:dateTime ,
      image: userModel.image
        );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {

      emit(SocialWriteCommentSuccessState());
    })
        .catchError((onError) {
      emit(SocialWriteCommentErrorState(onError.toString()));
    });
  }

  List<SocialChatModel> comments=[];
  void getComments(String postId,int index)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments=[];
      event.docs.forEach((element) {
        comments.add(SocialChatModel.fromJson(element.data()));
      });
      emit(SocialGetCommentsPostsSuccessState());
    });

  }


  List <SocialUserModel> users=[];
  void getUsers() {
    emit(SocialGetUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get()
        .then((value) {
      value.docs.forEach((element)
      {
        if(element.data()['uId']!=userModel.uId)users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetUsersSuccessState());
    })
        .catchError((onError) {
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }


  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
})
  {
    SocialChatModel model=SocialChatModel(
        text: text,
        senderId:userModel.uId ,
        dateTime:dateTime ,
        receiverId:receiverId);
    //Set My chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    //SET receiver CHAT
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });
  }

  List<SocialChatModel> messages=[];

  void getMessages({
    @required String receiverId,
  })
  {
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages=[];
      event.docs.forEach((element)
      {
        messages.add(SocialChatModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }

  void signOut()
  {
    emit(SocialSignOutLoadingState());
    FirebaseAuth.instance.signOut()
        .then((value)
    {
      CacheHelper.removeData(key: 'uId');
      emit(SocialSignOutSuccessState());
    })
        .catchError((onError)
    {
      emit(SocialSignOutErrorState());
    });

  }


double left=100;
  double i=0;
  void setLeft()
  {
    emit(ChangerLoading());
    while(DateTime.now().second<60) {
      left = left+1;
      print(DateTime.now().second);
      emit(ChangerSuccessfully());
    }
  }
}