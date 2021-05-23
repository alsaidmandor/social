import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/modules/newPost/newPost_sc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state  is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen(),);
          }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Search),
                onPressed: () {},
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Users'),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),

          /*ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            builder: (context) {
              var model = SocialCubit.get(context).userModel;
              return Column(
                children: [
                  // if (!FirebaseAuth.instance.currentUser.emailVerified)
                  //   Container(
                  //     color: Colors.amber.withOpacity(0.6),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 20.0,
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.info_outline,
                  //           ),
                  //           SizedBox(
                  //             width: 15.0,
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //               'Please verify your email',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 20.0,
                  //           ),
                  //           defaultTextButton(
                  //             function: () {
                  //               FirebaseAuth.instance.currentUser
                  //                   .sendEmailVerification()
                  //                   .then((value) {
                  //                 showToast(
                  //                   text: 'Check your mail',
                  //                   state: ToastStates.SUCCESS,
                  //                 );
                  //               }).catchError((error) {});
                  //             },
                  //             text: 'send ',
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   )
                ],
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          )*/
        );
      },
    );
  }
}
