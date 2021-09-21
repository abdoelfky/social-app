import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:social_app/social_models/post_model.dart';

import '../cubit.dart';
import '../states.dart';


class SocialCommentScreen extends StatelessWidget {
  var textController=TextEditingController();
  SocialPostModel model;
  var indexx;
  DateTime now = DateTime.now();
  SocialCommentScreen({this.model,this.indexx});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return  Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(backgroundColor: Colors.grey[100],),
            body: ConditionalBuilder(
              condition:SocialCubit.get(context).comments.length >0 ,
              builder:(context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: ListView.separated(
                          shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder:(context,index)
                            {
                              print('length ${SocialCubit.get(context).comments.length}');
                              return buildComment(context,index);
                            },
                            separatorBuilder: (context,index)=>SizedBox(height: 12,),
                            itemCount:SocialCubit.get(context).comments.length
                        ),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0,color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                    hintText: 'type your comment here ...',
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.lightBlueAccent,
                            child: MaterialButton(
                              height: 40.0,
                              minWidth: 50.0,
                              onPressed: ()
                              {
                                SocialCubit.get(context)
                                    .writeComment(postId: SocialCubit.get(context).postsId[indexx]
                                    , dateTime: '${DateFormat.MMMd().format(DateTime.now())} ${DateFormat.Hm().format(DateTime.now())}'
                                    , text:textController.text);
                                textController.text='';
                              }
                              ,
                              child:Icon(IconBroken.Send,size: 16.0,color: Colors.white,) ,),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback:(context)=>noComments(context) ,
            )
          );

        },

    );
  }

  Widget buildComment(context,index)=>Row(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 22.0,
          backgroundImage: NetworkImage('${SocialCubit.get(context).comments[index].image}'),
        ),
      ),
      SizedBox(width: 10,),
      Expanded(
        child: Container(
          // width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadiusDirectional.only(
                    bottomEnd:Radius.circular(10.0) ,
                    topStart: Radius.circular(10.0),
                    topEnd:Radius.circular(10.0)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:20 ,
                  vertical:5
              ),
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${SocialCubit.get(context).comments[index].dateTime}',
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,fontSize: 12),),
                          SizedBox(height: 5,),
                          Text(
                            '${SocialCubit.get(context).comments[index].text}',
                            maxLines: 180,
                            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),),
                          SizedBox(height: 5,),

                        ],
                      ),
                    ),
                    SizedBox(width: 30,),

                  ],
                ),
              ),
            )),
      ),

    ],
  );

  Widget noComments(context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(height: 30,),
        Center(child: Text('No Comments Yet',
          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 20),)),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: 'type your comment here ...',
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.lightBlueAccent,
              child: MaterialButton(
                height: 40.0,
                minWidth: 50.0,
                onPressed: ()
                {
                  SocialCubit.get(context)
                      .writeComment(postId: SocialCubit.get(context).postsId[indexx]
                      , dateTime: '${DateFormat.MMMd().format(DateTime.now())} ${DateFormat.Hm().format(DateTime.now())}'
                      , text:textController.text);
                  textController.text='';
                }
                ,
                child:Icon(IconBroken.Send,size: 16.0,color: Colors.white,) ,),
            ),
          ],
        ),

      ],
    ),
  );

}
