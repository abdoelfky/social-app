
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates{
  final error;
  SocialRegisterErrorState(this.error);
}//hello

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates{
  final error;

  SocialCreateUserErrorState(this.error);
}

class SocialChangePasswordVisibilityStates extends SocialRegisterStates{}


