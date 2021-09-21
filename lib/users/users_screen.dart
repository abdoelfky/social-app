import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_models/social_user_model.dart';
import 'package:social_app/users/user_profile_screen.dart';

import '../cubit.dart';
import '../states.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return ConditionalBuilder(
            condition:SocialCubit.get(context).users.length>0 ,
            builder:(context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>chatBuilder(context,SocialCubit.get(context).users[index]),
                  separatorBuilder:(context,index)=>myDivider(),
                  itemCount: SocialCubit.get(context).users.length
              ),
            ),
            fallback:(context)=>Center(child: CircularProgressIndicator()),
          );
        }

    );
  }

  Widget chatBuilder(context,SocialUserModel model)=>InkWell(
    onTap: ()
    {
      navigateTo(context,UserProfileScreen(model: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,height: 1.4),),
                        SizedBox(width: 5.0,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0,),
              IconButton(
                iconSize: 22.0,
                icon: Icon(IconBroken.Arrow___Right_2),
              )
            ],
          ),//handelling my avatar
          SizedBox(height: 8.0,)
        ],

      ),
    ),
  );

}
