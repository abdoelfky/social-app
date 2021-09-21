import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../cubit.dart';
import '../states.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state)
      {
        var userModel=SocialCubit.get(context).userModel;
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 240,
              child:
                  Stack(alignment: AlignmentDirectional.bottomCenter,
                      children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                              '${userModel.cover}'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        '${userModel.image}'),
                  ),
                ),
              ]),
            ),//الافاتار والكافر
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${userModel.name}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),),
            ),//الاسم
            Text('${userModel.bio}',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),),//البايوو
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('100',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),),
                          Text('Posts',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('100',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),),
                          Text('Photos',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('100',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),),
                          Text('Followers',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children:
                        [
                          Text('100',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),),
                          Text('Followings',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),)
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
            Row(
              children:
              [
                Expanded(
                  flex: 4,
                    child: OutlineButton
                      (
                      onPressed: (){},
                      child: Text('Add Photos',style: TextStyle(color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),),
                    )),
                SizedBox(width: 8,),
                Expanded(
                    child: OutlineButton
                      (
                      onPressed: ()
                      {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(IconBroken.Edit_Square,size: 20.0,color: Colors.blue,),
                    )),
              ],
            ),//اضافه صوره , عمل تعديل

          ],
        ),
      );
      }
    );
  }
}
