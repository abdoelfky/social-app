abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfilePickedSuccessState extends SocialStates{}

class SocialProfilePickedErrorState extends SocialStates{}

class SocialCoverPickedSuccessState extends SocialStates{}

class SocialCoverPickedErrorState extends SocialStates{}

class SocialUploadProfileSuccessState extends SocialStates{}

class SocialUploadProfileErrorState extends SocialStates{}

class SocialUploadCoverSuccessState extends SocialStates{}

class SocialUploadCoverErrorState extends SocialStates{}

class SocialUpdateLoadingState extends SocialStates{}

class SocialUpdateSuccessState extends SocialStates{}

class SocialUpdateErrorState extends SocialStates{}

//Post
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePickedState extends SocialStates{}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostsSuccessState extends SocialStates{}

class SocialLikePostsErrorState extends SocialStates
{
  final String error;

  SocialLikePostsErrorState(this.error);
}

class SocialWriteCommentSuccessState extends SocialStates{}

class SocialWriteCommentErrorState extends SocialStates{
  final String error;

  SocialWriteCommentErrorState(this.error);
}

class SocialGetCommentsPostsSuccessState extends SocialStates{}

class SocialGetLengthCommentsPostsSuccessState extends SocialStates{}

class SocialDisLikePostsSuccessState extends SocialStates{}

class SocialDisLikePostsErrorState extends SocialStates
{
  final String error;

  SocialDisLikePostsErrorState(this.error);
}

class SocialGetLikePostsSuccessState extends SocialStates{}

//users-Chats

class SocialGetUsersLoadingState extends SocialStates{}

class SocialGetUsersSuccessState extends SocialStates{}

class SocialGetUsersErrorState extends SocialStates{}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}

class SocialSignOutLoadingState extends SocialStates{}

class SocialSignOutSuccessState extends SocialStates{}

class SocialSignOutErrorState extends SocialStates{}

class ChangerLoading extends SocialStates{}

class ChangerSuccessfully extends SocialStates{}
