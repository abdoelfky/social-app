import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/post/post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_login_screen/social_login_screen.dart';

import '../cubit.dart';
import '../states.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state)
      {
        if(state is SocialNewPostState)navigateTo(context, PostScreen());
        if (state is SocialSignOutSuccessState)navigateAndEnd(context, SocialLoginScreen());

      } ,
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex],
              style: TextStyle(color: Colors.blue[600],fontSize:25 ,
                  fontWeight: FontWeight.w800),),
            actions: [
              IconButton(icon: Icon(IconBroken.Notification),onPressed: (){},),
              IconButton(icon: Icon(IconBroken.Search),onPressed: (){}),
              IconButton(icon:Icon(IconBroken.Logout) ,color: Colors.red[500], onPressed: ()
              {
                SocialCubit.get(context).signOut();
                if (state is SocialSignOutSuccessState)navigateAndEnd(context, SocialLoginScreen());

              })

            ],
          ),
          body: cubit.socialScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            iconSize:25,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Setting),label: 'Settings'),



            ],
          ),
        );} ,

    );
  }
}
