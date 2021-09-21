import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_layout/social_layout.dart';
import 'package:social_app/social_login_screen/cubit/cubit.dart';
import 'package:social_app/social_login_screen/cubit/states.dart';
import 'package:social_app/social_register_screen/social_register_screen.dart';
import 'package:social_app/social_register_screen/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialStates>(
        listener: (context,state)
        {if(state is SocialLoginSuccessState)
        {

          CacheHelper.saveData(key: 'uId', value: state.uId);
          Fluttertoast.showToast(
            msg: 'Login Success',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          if(state is SocialLoginSuccessState)navigateAndEnd(context, SocialLayout());

        }
          if(state is SocialLoginErrorState)
          {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder:(context,state){
          return  Scaffold(
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50]
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/images/undraw_Login.png'),width: 300),
                          Text('Welcome back!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.0
                            ),),
                          SizedBox(height: 8.0,),
                          Text('Login in to your account to contact with others',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.5,
                                color: Colors.grey[400]
                            ),),
                          SizedBox(height: 30.0,),
                          defaultFormFeild(
                              validatorText: 'please enter your Email Address',
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              prefixIcon: Icon(IconBroken.User),
                              labelText: 'Email Address'
                          ),
                          SizedBox(height: 15.0,),
                          defaultFormFeild(
                            validatorText: 'please enter your Password',
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icon(IconBroken.Lock),
                            suffixIcon: SocialLoginCubit.get(context).suffix,
                            suffixPressed:()
                            {
                              SocialLoginCubit.get(context).changePasswordVisibility();
                            },
                            isObsecured: SocialLoginCubit.get(context).isPasswordShown,
                            labelText: 'Password',
                          ),
                          Container(
                            alignment:AlignmentDirectional.centerEnd,
                            child: TextButton(
                                onPressed: (){},
                                child:Text('Forget Password',style: TextStyle(color: Colors.black),)
                            ),
                          ),
                          ConditionalBuilder(
                            condition:state is! SocialLoginLoadingState ,
                            builder:(context)=>defaultButton(
                                string: 'LOG IN',
                                function: (){
                                  if(formKey.currentState.validate())
                                  {print(emailController.text);
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  }
                                },
                                color: Colors.purpleAccent),
                            fallback:(context)=> Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(height: 40.0,),
                          Text('OR connect using',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.5,
                                color: Colors.grey[400]
                            ),),
                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Container(
                                decoration: BoxDecoration(
                            color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(10)
                          ),
                                child: MaterialButton(
                                    minWidth: 140,
                                    onPressed: (){},
                                  child:Row(
                                    children: [
                                      Text('F  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white
                                        ),),
                                      Text('Facebook',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white
                                        ),),
                                    ],
                                  )
                                ),
                              ),
                              SizedBox(width: 12,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: MaterialButton(
                                  minWidth: 140,
                                    onPressed: (){},
                                    child:Row(
                                      children: [
                                        Text('G  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white
                                          ),),
                                        Text('Google',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white
                                          ),),
                                      ],
                                    )
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 40.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(fontSize: 18.0
                                    ,fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),

                              ),
                              TextButton(
                                onPressed: (){
                                  navigateTo(context, SocialRegisterScreen());
                                }                    ,
                                child:Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 16.5
                                      ,fontWeight: FontWeight.bold,
                                  color: Colors.blue),

                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
