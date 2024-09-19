
import 'package:chat_app/color_app.dart';
import 'package:chat_app/feature/chat/chat.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomItem extends StatelessWidget {
  MyRooms myRooms;
   RoomItem({super.key,required this.myRooms});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatScreen.routeName,arguments: myRooms);
      },
      child: Container(
      margin: EdgeInsets.all(15),

        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorApp.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SizedBox(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/${myRooms.categoryId}.png",
                height: 60.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  myRooms.roomTitle,

                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
