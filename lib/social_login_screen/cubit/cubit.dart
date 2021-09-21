import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_login_screen/cubit/states.dart';
import 'package:social_app/social_login_screen/shop_login_model.dart';

class SocialLoginCubit extends Cubit<SocialStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  })
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value)
    {
      print(value.user.uid);
      print(value.user.email);

      emit(SocialLoginSuccessState(value.user.uid));
    })
        .catchError((onError)
    {
      emit(SocialLoginErrorState(onError.toString()));
    });

  }

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=true;
  void changePasswordVisibility()
  {
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());

  }
}
