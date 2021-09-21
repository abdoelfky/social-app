import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../cubit.dart';
import '../states.dart';


class EditProfileScreen extends StatelessWidget {

  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state)
      {

      } ,
      builder:(context,state)
      {

        var userModel=SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=userModel.name;
        bioController.text=userModel.bio;
        phoneController.text=userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(context: context,
              title: 'Edit Profile ',
              actions: [
                defaultButton2(
                    color: Colors.white,
                    string: 'Update',
                    function: ()
                    {
                      SocialCubit.get(context)
                          .updateUserData(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text,
                      );

                    },
                    width: 140
                )
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateLoadingState)LinearProgressIndicator(),
                  SizedBox(height: 8.0,),
                  Container(
                    height: 240,
                    child:
                    Stack(alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
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
                                        image: coverImage==null?NetworkImage(
                                            '${userModel.cover}'):FileImage(coverImage),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                      icon: Icon(IconBroken.Camera,
                                        color: Colors.white,
                                        size: 22.0,

                                      ),
                                      onPressed: ()
                                      {
                                        SocialCubit.get(context).getCoverImage();
                                      }),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children:
                          [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage ==null ? NetworkImage(
                                    '${userModel.image}') : FileImage(profileImage),
                              ),
                            ),
                            CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                  icon: Icon(IconBroken.Camera,
                                    color: Colors.white,
                                    size: 18.0,

                                  ),
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getProfileImage();
                                  }),
                            )

                          ],)
                        ]),
                  ),//الافاتار والكافر
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                    Row(
                    children:
                    [
                      if(SocialCubit.get(context).profileImage!=null&&state is SocialProfilePickedSuccessState )
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(color: Colors.white,string: 'Upload image',
                                function:
                                ()
                            {
                              SocialCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text);
                            }),
                            if(state is SocialUpdateLoadingState)LinearProgressIndicator(),
                            SizedBox(height: 10.0,)
                          ],
                        ),
                      ),
                      if(SocialCubit.get(context).coverImage!=null&&state is SocialCoverPickedSuccessState)Expanded(
                        child: Column(
                          children: [
                            defaultButton(color: Colors.white,string: 'Upload Cover', function:
                                ()
                            {
                              SocialCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text);
                            }),
                            if(state is SocialUpdateLoadingState)LinearProgressIndicator(),
                            SizedBox(height: 10.0,)
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 8,),
                  defaultFormFeild(
                      validatorText: 'Name Must\'t be empty',
                      controller: nameController,
                      inputType: TextInputType.name,
                      prefixIcon: Icon(IconBroken.User),
                      labelText: 'Name'),
                  SizedBox(height: 8,),
                  defaultFormFeild(
                      controller: bioController,
                      inputType: TextInputType.text,
                      prefixIcon: Icon(IconBroken.Info_Circle),
                      labelText: 'Bio'
                  ),
                  SizedBox(height: 8,),
                  defaultFormFeild(
                      controller: phoneController,
                      inputType: TextInputType.phone,
                      prefixIcon: Icon(IconBroken.Call),
                      labelText: 'Phone'
                  ),
                ],
              ),
            ),
          ),
        );
      } ,
    );
  }
}
