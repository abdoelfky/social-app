import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../cubit.dart';
import '../states.dart';

class PostScreen extends StatefulWidget {

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var textController=TextEditingController();
  int activeIndex=0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Add Post',
                actions: [TextButton(onPressed: ()
                {
                  if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createNewPost(postText: textController.text,
                        dateTime:DateTime.now().toString());
                  }
                  else
                    {
                      SocialCubit.get(context).uploadPostImage(postText: textController.text,
                          dateTime:DateTime.now().toString());
                    }
                  textController.text='';
                },
                    child: Text('POST',
                      style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w900),))]
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialCreatePostLoadingState)
                    SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(SocialCubit.get(context).userModel.image),
                              ),
                              SizedBox(width: 15.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(SocialCubit.get(context).userModel.name,
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,height: 1.4),),
                                      ],
                                    )
                                  ],),
                              ),
                              SizedBox(width: 15.0,),
                            ],
                          ),//handelling my avatar
                          SizedBox(height: 20.0,),
                          TextFormField(
                            maxLines: 4,
                            controller: textController,
                            decoration:InputDecoration(
                              helperMaxLines: 6,
                              hintText: 'What is on your mind ...',
                              border: InputBorder.none
                            ),
                          ),
                          SizedBox(height: 25.0,),
                          if(SocialCubit.get(context).postImages.length ==1)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Column(
                                      children: [
                                        Container(
                                                height: 180,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4.0),
                                                  image: DecorationImage(
                                                      image: FileImage(SocialCubit.get(context).postImages[0]),
                                                      fit: BoxFit.cover),
                                                ),
                                              )
                                      ],
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[800],
                                    child: IconButton(
                                        icon: Icon(Icons.close,
                                          color: Colors.white,
                                          size: 22.0,

                                        ),
                                        onPressed: ()
                                        {
                                          SocialCubit.get(context).removePostImage(0);
                                        }),
                                  ),
                                )
                              ],
                            ),
                          if(SocialCubit.get(context).postImages.length >1)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Column(
                                    children: [
                                      CarouselSlider.builder(
                                          itemCount: SocialCubit.get(context).postImages.length,
                                          itemBuilder:(context,index,realIndex)
                                          {

                                            return Container(
                                              height: 180,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4.0),
                                                image: DecorationImage(
                                                    image: FileImage(SocialCubit.get(context).postImages[index]),
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
                                              dotHeight: 20,
                                              dotWidth: 20,
                                              dotColor: Colors.grey,
                                              activeDotColor: Colors.blue
                                          ),
                                          activeIndex: activeIndex,
                                          count: SocialCubit.get(context).postImages.length)

                                    ],
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[800],
                                    child: IconButton(
                                        icon: Icon(Icons.close,
                                          color: Colors.white,
                                          size: 22.0,

                                        ),
                                        onPressed: ()
                                        {
                                          SocialCubit.get(context).removePostImage(activeIndex);
                                        }),
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),//write post
                      SizedBox(height: 10.0,),
                      Row(
                    children: [
                      Expanded(
                        child: TextButton(

                            onPressed: ()
                            {
                                  SocialCubit.get(context).getPostImage();
                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Image),
                                SizedBox(width: 5.0,),
                                Text('add photo')
                              ],)),
                      ),//add photo
                      Expanded(
                        child: TextButton(onPressed: (){},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('# tags')
                              ],)),
                      ),//# tags
                    ],),//# tags,add photos

                ],
              ),
            ),
          );
        }
        );
  }
}
