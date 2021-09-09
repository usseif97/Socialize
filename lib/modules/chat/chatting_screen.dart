import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/models/message_model.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/styles/colors.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class ChattingScreen extends StatelessWidget {
  final UserModel userModel;
  ChattingScreen({Key? key, required this.userModel}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // use Builder here to assure get messages first before render the screen
    return Builder(builder: (context) {
      HomeCubit.get(context).getMessages(receiverId: userModel.uID);
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      userModel.image,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    userModel.name,
                  ),
                ],
              ),
            ),
            body: state is HomeGetAllMessagesLoadingState
                ? Center(child: CircularProgressIndicator())
                : HomeCubit.get(context).messages.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message =
                                      HomeCubit.get(context).messages[index];
                                  if (HomeCubit.get(context).userModel!.uID ==
                                      message.senderId)
                                    return _buildMyMessage(message);
                                  else
                                    return _buildReceiverMessage(message);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 5.0),
                                itemCount:
                                    HomeCubit.get(context).messages.length,
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: _buildBottomBar(context)),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text('No Chat !!'),
                            ),
                            Spacer(),
                            _buildBottomBar(context),
                          ],
                        ),
                      ),
          );
        },
      );
    });
  }

  Widget _buildReceiverMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text),
        ),
      );

  Widget _buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text),
        ),
      );

  Widget _buildBottomBar(context) => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'type your message here ...',
                ),
              ),
            ),
          ),
          Container(
            width: 50.0,
            child: MaterialButton(
              onPressed: () {
                HomeCubit.get(context).sendMessage(
                  receiverId: userModel.uID,
                  dateTime: DateTime.now().toString(),
                  text: messageController.text,
                );
                messageController.text = '';
              },
              minWidth: 1.0,
              child: Icon(IconBroken.Send),
            ),
          ),
        ],
      );
}
