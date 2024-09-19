import 'package:chat_app/color_app.dart';
import 'package:chat_app/feature/chat/view_model/chat_screen_connector.dart';
import 'package:chat_app/feature/chat/view_model/view_model.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/widget/TextFieldCustom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';
import '../../provider/save_user.dart';
import '../../widget/dialog_utils.dart';
import 'message.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat_screen";
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    implements ChatScreenConnector {
  ChatViewModel chatViewModel = ChatViewModel();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatViewModel.scrollController.hasClients) {
        chatViewModel.scrollController.animateTo(
          chatViewModel.scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    chatViewModel.scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    chatViewModel.chatScreenConnector = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as MyRooms;
    var provider = Provider.of<SaveUser>(context);

    chatViewModel.room = args;
    chatViewModel.currentUser = provider;
    chatViewModel.listenUpdateMessage();

    return ChangeNotifierProvider(
      create: (context) => chatViewModel,
      child: Stack(
        children: [
          Container(
            color: ColorApp.whiteColor,
          ),
          Image.asset(
            "assets/images/SIGN IN – 1.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              title: Text(
                args.roomTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorApp.whiteColor),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 8.w),
                padding: const EdgeInsets.all(20),
                height: 500.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: ColorApp.whiteColor,
                  borderRadius: BorderRadius.circular(15), // Background color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder<QuerySnapshot<Message>>(
                          stream: chatViewModel.streamMessage,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else {
                              var messages = snapshot.data!.docs.map(
                                    (doc) {
                                  return doc.data();
                                },
                              ).toList();

                              // Scroll to bottom after data is built
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollToBottom();
                              });

                              return ListView.builder(
                                controller: chatViewModel.scrollController,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  return MessageWidget(message: messages[index]);
                                },
                              );
                            }
                          },
                        )),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Textfieldcustom(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "enter a message";
                              }
                              return null;
                            },
                            controller: chatViewModel.messageController,
                            lableText: "Type a message",
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 25.h, horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: ColorApp.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "send",
                                  style: TextStyle(
                                    color: ColorApp.whiteColor,
                                  ),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      chatViewModel.sendMessage();
                                      scrollToBottom();
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      size: 12,
                                      color: ColorApp.whiteColor,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(
      context: context,
      message: message,
      posActionName: "oK",
    );
  }
}
