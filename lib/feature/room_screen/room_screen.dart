import 'package:chat_app/feature/room_screen/view_model/room_screen_connector.dart';
import 'package:chat_app/feature/room_screen/view_model/view_model.dart';
import 'package:chat_app/model/category.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/provider/save_user.dart';
import 'package:chat_app/widget/dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../color_app.dart';
import '../../widget/TextFieldCustom.dart';
import '../home_screen/home_screen.dart';

class RoomScreen extends StatefulWidget {
  static const String routeName = "room_screen";
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    implements RoomScreenConnector {
  RoomViewModel roomViewModel = RoomViewModel();

  var categories = MyCategory.getCategory();
  late MyCategory selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomViewModel.roomScreenConnector = this;
    selectedCategory = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => roomViewModel,
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
                "Chat App",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorApp.whiteColor),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 8.w),
              padding: const EdgeInsets.all(20),
              height: 450.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: ColorApp.whiteColor,
                borderRadius: BorderRadius.circular(20), // Background color
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
              child: SingleChildScrollView(
                child: Form(
                  key: roomViewModel.form,
                  child: Column(
                    children: [
                      Text(
                        "Create New Room",
                        style: TextStyle(fontSize: 25.sp),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Image.asset(
                        "assets/images/room.png",
                        height: 100,
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter room name";
                          }
                          return null;
                        },
                        controller: roomViewModel.roomName,
                        lableText: "Enter Room Name",
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton(
                                dropdownColor: Colors.white,
                                value: selectedCategory,
                                items: categories.map(
                                  (category) {
                                    return DropdownMenuItem(
                                        value: category,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(category.title),
                                            Image.asset(
                                              category.image,
                                              height: 100,
                                            ),
                                          ],
                                        ));
                                  },
                                ).toList(),
                                onChanged: (MyCategory? category) {
                                  selectedCategory = category!;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter room desc";
                          }
                          return null;
                        },
                        controller: roomViewModel.roomDesc,
                        lableText: "Enter Room Descreption",
                      ),
                      InkWell(
                        onTap: () {
                          validatorForm();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 25.h, horizontal: 8.w),
                          padding: const EdgeInsets.all(12),
                          height: 35.h,
                          width: 210.w,
                          decoration: BoxDecoration(
                            color: ColorApp.primaryColor, // Background color
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            "Create",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorApp.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validatorForm() {
    if (roomViewModel.form.currentState!.validate()) {
      roomViewModel.addRoom(roomViewModel.roomName.text, roomViewModel.roomDesc.text, selectedCategory.id);
    }
  }

  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMessage(String message,String title,String actionButtonName ,[MyUser? user]) {
    var userProvider=Provider.of<SaveUser>(context,listen: false);
    userProvider.myUser=user;
    DialogUtils.showMessage(context: context, message: message,
        title: title,
        posAction: (){
          if(actionButtonName == "ok"){
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
                  (route) => false,
            );
          }
        },
        posActionName: actionButtonName
    );
  }
}
