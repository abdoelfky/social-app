import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/comment/comment_screen.dart';
import 'package:social_app/post/post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_models/post_model.dart';

import '../cubit.dart';
import '../states.dart';

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  int activeIndex=0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        if (state is !SocialGetPostsLoadingState)
        {
          Future.delayed(Duration(seconds: 5));
        }
      },
      builder:(context,state)
      {

        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).userModel!=null,
          builder:(context)=>RefreshIndicator(
            onRefresh:() async {
              SocialCubit.get(context).getPosts();
            } ,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 10.0,
                    child:
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                          [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: CircleAvatar(
                                radius:20 ,
                                backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),
                              ),
                            ),
                            InkWell(
                              onTap: ()
                              {
                                navigateTo(context, PostScreen());
                              },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 120,top:25 ,bottom: 25,left: 15),
                                  child: Text('What\'s on your mind? ',style: TextStyle(color:Colors.grey[900]),),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Container(
                            width: double.infinity,
                            height:1,
                            color: Colors.grey[300],
                          ),
                        ),
                        Row(
                          children:
                          [
                            Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                  child: Row(
                                    children:
                                    [
                                      Container(width: 32,child:Icon(Icons.video_call_rounded,
                                          color: Colors.red[700],size: 22)),
                                      Text('Live',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.5,color: Colors.grey[800]),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 24,width: 1,color: Colors.grey[300],),
                            Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                  child: Row(
                                    children:
                                    [
                                      Container(width: 30,child:Icon(Icons.photo_library_outlined,
                                        color: Colors.green[400],size: 20,)),
                                      Text('Photo',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: Colors.grey[800]),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 24,width: 1,color: Colors.grey[300],),
                            Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                  child: Row(
                                    children:
                                    [
                                      Container(width: 30,child:Icon(Icons.video_call_sharp,
                                        color: Colors.purple[400],size: 20,)),
                                      Text('Room',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: Colors.grey[800]),)
                                    ],
                                  ),
                                ),
                              ),
                            ),


                          ],
                        )

                      ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 10.0,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Audio & Video Rooms',
                            style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10,left: 10),
                                  child: Container(
                                    width:120 ,
                                    height:40 ,
                                    decoration: BoxDecoration(
                                      color:Colors.blue.shade50,
                                      borderRadius:BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Create Room',
                                        style: TextStyle(color: Colors.blue[700],fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                  width:MediaQuery.of(context).size.width,
                                  child:
                                  ListView.separated(
                                    shrinkWrap:true ,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:(context,index)=>buildStates(context,index),
                                    separatorBuilder: (context,index)=>SizedBox(width: 0,),
                                    itemCount: SocialCubit.get(context).users.length,
                                  ),


                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder:(context,index)=>SizedBox(height: 10.0,),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context,index)
                    {
                    return buildPostItem(SocialCubit.get(context).posts[index],context,index);
                    },
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(height: 8.0,)
                ],
              ),
            ),
          ) ,
          fallback:(context)=> Column(
            children: [
              Card(
                margin: EdgeInsets.only(bottom: 10),
                elevation: 10.0,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: CircleAvatar(
                        radius:20 ,
                        backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),
                      ),
                    ),
                    InkWell(
                        onTap: ()
                        {
                          navigateTo(context, PostScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 120,top:25 ,bottom: 25,left: 15),
                          child: Text('What\'s on your mind? ',style: TextStyle(color:Colors.grey[900]),),
                        )),
                  ],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              SizedBox(height: 220,),
              Center(child: CircularProgressIndicator()),
            ],
          ),
        );

      } ,
    );
  }

  Widget buildPostItem(SocialPostModel model,context,index)=>Card(
      margin: EdgeInsets.only(top:0 ,bottom:0 ),
      elevation: 10.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child:Padding(
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
                          Icon(Icons.check_circle,color: Colors.blue,size: 16,)
                        ],
                      ),
                      Text('${model.dateTime}',
                        style: TextStyle(fontSize: 12.0,color: Colors.grey,height: 1.4),),

                    ],),
                ),
                SizedBox(width: 15.0,),
                IconButton(
                  iconSize: 22.0,
                  icon: Icon(Icons.more_horiz),
                  onPressed: (){},
                )

              ],
            ),//handelling my avatar
            myDivider(),
            SizedBox(height: 4,),
            Text('${model.postText}',
              style:TextStyle(fontWeight: FontWeight.w500) ,), //post Text
            SizedBox(height: 4,),
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
              if(model.postImage.length==1)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                height:200 ,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image:DecorationImage(image :
                  NetworkImage('${model.postImage[0]}',),
                      fit: BoxFit.cover),
                ),
            ),
              ),//صوره البوست
              if(model.postImage.length>1)
                Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Column(
                      children: [
                        SizedBox(height: 20.0,),
                        CarouselSlider.builder(
                            itemCount: model.postImage.length,
                            itemBuilder:(context,index,realIndex)
                            {

                              return Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: DecorationImage(
                                      image: NetworkImage(model.postImage[index]),
                                      fit: BoxFit.cover),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              onPageChanged: (index,reason){setState(() {
                                activeIndex=index;
                              });},
                              enlargeCenterPage: true,
                              height: 400,
                            )
                        ),
                        SizedBox(height: 30,),
                        AnimatedSmoothIndicator(
                            effect: WormEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.blue
                            ),
                            activeIndex: activeIndex,
                            count:model.postImage.length
                        ),
                      ],
                    )
                ),
            Padding(
              padding: const EdgeInsets.only(top:3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:
                [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children:
                          [
                            Icon(IconBroken.Heart,size: 18,color: Colors.red,),
                            SizedBox(width: 5,),
                            Text('${SocialCubit.get(context).likes[index]}',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(

                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6,bottom:4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                          [
                            Icon(IconBroken.Message,size: 18,color: Colors.amber,),
                            SizedBox(width: 5,),
                            Text('${SocialCubit.get(context).comments.length} Comments',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),

                ],),
            ),//عدد اللايكات
            myDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius:16 ,
                  backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),
                ),
                SizedBox(width: 15.0,),
                Expanded(
                    flex: 5,
                    child: InkWell(
                        onTap: ()
                        {
                          SocialCubit.get(context).getComments(SocialCubit.get(context).postsId[index],index);
                          navigateTo(context, SocialCommentScreen(model: model,indexx: index,));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Write a comment ...',
                            style: TextStyle(color: Colors.grey),),
                        ))),
                SizedBox(width: 15.0,),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end  ,
                        children:
                        [
                          Icon(SocialCubit.get(context).likeIcon[index],size: 18,color: Colors.red,),
                          Text(' Like',style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ),
                    onTap: ()
                    {
                      if(!SocialCubit.get(context).currentLike)
                      {
                        SocialCubit.get(context).likePosts(SocialCubit.get(context).postsId[index],index);
                        print(SocialCubit.get(context).postsId[index]);
                      }
                      else
                        {
                          SocialCubit.get(context).disLikePosts(SocialCubit.get(context).postsId[index],index);
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


Widget buildStates(context,index)=>Container(
  width: 50,
  child: Column(
    //states
    children: [
      Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        CircleAvatar(
          radius: 18.0,
          backgroundImage: NetworkImage('${SocialCubit.get(context).users[index].image}'),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: 2.8,
            end: 3.0,
          ),
          child: CircleAvatar(
            radius: 5.0,
            backgroundColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: 3.0,
            end: 3.0,
          ),
          child: CircleAvatar(
            radius: 4.5,
            backgroundColor: Colors.green,
          ),
        ),
      ]),
    ],
  ),
);//States

