import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_layout/social_layout.dart';
import 'package:social_app/social_login_screen/social_login_screen.dart';
import 'package:social_app/social_register_screen/cubit/register_cubit.dart';
import 'package:social_app/social_register_screen/cubit/register_states.dart';

class SocialRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordConfirmController=TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context,state)
        {if(state is SocialCreateUserSuccessState)
        {
          if(state is SocialRegisterSuccessState)navigateAndEnd(context, SocialLayout());

          Fluttertoast.showToast(
            msg: 'Register Success',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
       else if(state is SocialRegisterErrorState)
        {
          Fluttertoast.showToast(
            msg: state.error.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(backgroundColor:Colors.grey[100],
              shadowColor:Colors.grey[100]
            ),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100]
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Let\' Get Started!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Create an account to Social Q to get all features',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.5,
                              color: Colors.grey[400]
                          ),),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'please enter your Name',
                          controller: nameController,
                          inputType: TextInputType.name,
                          prefixIcon: Icon(IconBroken.User),
                          labelText: 'Name',
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFeild(
                            validatorText: 'please enter your Email Address',
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email Address'),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'please enter your Phone Number',
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          prefixIcon: Icon(Icons.phone_iphone),
                          labelText: 'Phone Number',
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'please enter your Password',
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icon(IconBroken.Lock),
                          suffixIcon: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isObsecured:
                          SocialRegisterCubit.get(context).isPasswordShown,
                          labelText: 'Password',
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFeild(
                          validatorText: 'Password not match',
                          controller: passwordConfirmController,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icon(IconBroken.Lock),
                          suffixIcon: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isObsecured:
                          SocialRegisterCubit.get(context).isPasswordShown,
                          labelText: 'Confirm Password',
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is !SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              string: 'Create',
                              function: () {
                                if (formKey.currentState.validate()) {
                                  print(emailController.text);
                                  SocialRegisterCubit.get(context)
                                      .userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                };
                                navigateAndEnd(context, FeedsScreen());
                              },
                              color: Colors.purpleAccent),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(fontSize: 18.0
                                  ,fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),

                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndEnd(context, SocialLoginScreen());
                              },
                              child: Text(
                                'Login here',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,color: Colors.blue),
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
          );
        },
      ),
    );
  }
}
