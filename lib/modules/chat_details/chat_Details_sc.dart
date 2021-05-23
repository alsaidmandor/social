import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/user.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({this.userModel});

  var message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // using builder to get data before start BlocConsumer
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(
          receiverId: userModel.uId,
        );

        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SocialCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('${userModel.name}'),
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: cubit.messages.length > 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: cubit.messages.length,
                            itemBuilder: (context, index) {
                              var message = cubit.messages[index];
                              if (cubit.userModel.uId ==
                                  cubit.messages[index].senderId)
                                return buildMyMessage(message);
                              return buildMessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15.0,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300],
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: TextFormField(
                                    controller: message,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'type your message here  ...'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50.0,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                      receiverId: userModel.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: message.text,
                                    );
                                  },
                                  minWidth: 1.0,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget buildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text('${model.text}'),
      ),
    );
  }

  Widget buildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        child: Text('${model.text}'),
      ),
    );
  }
}
