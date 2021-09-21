
abstract class SocialStates {}

class SocialLoginInitialState extends SocialStates{}

class SocialLoginLoadingState extends SocialStates{}

class SocialLoginSuccessState extends SocialStates
{
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialStates{
  final error;
  SocialLoginErrorState(this.error);

}

class SocialChangePasswordVisibilityState extends SocialStates{}


