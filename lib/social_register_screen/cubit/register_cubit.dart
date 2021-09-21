import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_login_screen/shop_login_model.dart';
import 'package:social_app/social_models/social_user_model.dart';
import 'package:social_app/social_register_screen/cubit/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(email: email, name: name, phone: phone, uId: value.user.uid);
    }).catchError((onError) {
      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

  void userCreate({
    @required String email,
    @required String name,
    @required String phone,
    @required String uId,


  }) {
    SocialUserModel model=SocialUserModel(
        name:name ,
        bio:'Write your bio ...',
        email:email ,
        phone:phone ,
        uId: uId,
        isEmailVerified: false,
        cover: 'https://image.freepik.com/free-photo/shot-young-blonde-long-haired-pretty-woman-elegant-clothes-walking-outdoor-weekend-drinking-cup-coffee-while-waiting-friends-looking-attentively_295783-5243.jpg',
        image: 'https://cdn2.momjunction.com/wp-content/uploads/2021/02/What-Is-A-Sigma-Male-And-Their-Common-Personality-Trait-910x1024.jpg'
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError)
    {
      emit(SocialCreateUserErrorState(onError.toString()));

    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityStates());
  }
}
