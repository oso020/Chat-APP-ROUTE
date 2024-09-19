
import 'package:chat_app/color_app.dart';
import 'package:chat_app/feature/chat/view_model/view_model.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/widget/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName="chat_screen";
   ChatScreen({super.key});
  ChatViewModel chatViewModel =ChatViewModel();
  @override
  Widget build(BuildContext context) {
    var args =ModalRoute.of(context)!.settings.arguments as MyRooms ;
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
                IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
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
                      color: Colors.grey
                          .withOpacity(0.5), // Shadow color with opacity
                      spreadRadius: 3, // Spread radius of the shadow
                      blurRadius: 2, // Blur radius of the shadow
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Spacer(),

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
                            controller: chatViewModel.message,
                            lableText: "Type a message",
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical:25.h,horizontal:8.w  ),

                            decoration: BoxDecoration(
                              color: ColorApp.primaryColor     , // Background color
                              borderRadius: BorderRadius.circular(10),
                          
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("send",
                                  style: TextStyle(
                                    color: ColorApp.whiteColor,
                          
                                  ),
                                ),
                          
                                IconButton(
                                  padding: EdgeInsets.zero,
                                    onPressed: (){
                          
                                }, icon: Icon(Icons.send,
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
}
