import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/user.dart';
import 'package:social/modules/chat_details/chat_Details_sc.dart';
import 'package:social/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.users.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  buildChatItem(context, cubit.users[index]),
              separatorBuilder: (BuildContext context, int index) =>
                  myDivider(),
              itemCount: cubit.users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
