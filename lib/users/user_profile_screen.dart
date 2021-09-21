import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_models/post_model.dart';
import 'package:social_app/social_models/social_user_model.dart';

import '../states.dart';


class UserProfileScreen extends StatelessWidget {
  SocialUserModel model;

  UserProfileScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(model.name),),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 240,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
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
                                      image: NetworkImage('${model.cover}'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage('${model.image}'),
                              ),
                            ),
                          ]),
                    ), //الافاتار والكافر
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${model.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ), //الاسم
                    Text(
                      '${model.bio}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ), //البايوو
                    myDivider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Posts',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          )),
                    ),
                    ConditionalBuilder(
                      condition: SocialCubit.get(context).posts.length>0,
                      builder:(context)=> ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.0,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {

                          if(SocialCubit.get(context).posts[index].uId==model.uId)
                          {
                            return buildPostItem(
                                SocialCubit.get(context).posts[index],
                                context,
                                index);
                          }
                          else
                            {
                             return Container();
                            }

                        },
                        itemCount:SocialCubit.get(context).posts.length,
                      ),
                      fallback:(context)=>CircularProgressIndicator() ,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildPostItem(SocialPostModel model, context, index) => Card(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        elevation: 6.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    iconSize: 22.0,
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  )
                ],
              ), //handelling my avatar
              myDivider(),
              SizedBox(
                height: 4,
              ),
              Text(
                '${model.postText}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ), //كلام البوست
              SizedBox(
                height: 4,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 10,
              //       bottom: 5.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6.0),
              //           child: Container(
              //             height: 20.0,
              //             child: MaterialButton(
              //               onPressed: (){},
              //               height:25 ,
              //               minWidth:1 ,
              //               padding: EdgeInsets.zero,
              //               child: Text('#Software',
              //                 style: TextStyle(color: Colors.blue),),
              //
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 6.0),
              //           child: Container(
              //             height: 20.0,
              //             child: MaterialButton(
              //               onPressed: (){},
              //               height:25 ,
              //               minWidth:1 ,
              //               padding: EdgeInsets.zero,
              //               child: Text('#Flutter',
              //                 style: TextStyle(color: Colors.blue),),
              //
              //             ),
              //           ),
              //         ),
              //
              //
              //       ],
              //     ),
              //   ),
              // ),//التاجز
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: NetworkImage(
                            '${model.postImage}',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ), //صوره البوست
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Message,
                                size: 18,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0 Comment',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ), //عدد اللايكات
              myDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                      flex: 5,
                      child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Write a comment ...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ))),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              SocialCubit.get(context).likeIcon[index],
                              size: 18,
                              color: Colors.red,
                            ),
                            Text(
                              ' Like',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (!SocialCubit.get(context).currentLike) {
                          SocialCubit.get(context).likePosts(
                              SocialCubit.get(context).postsId[index], index);
                          print(SocialCubit.get(context).postsId[index]);
                        } else {
                          SocialCubit.get(context).disLikePosts(
                              SocialCubit.get(context).postsId[index], index);
                          print(SocialCubit.get(context).postsId[index]);
                        }
                      },
                    ),
                  ),
                ],
              ),
              myDivider(),
            ],
          ),
        ),
      );
}
