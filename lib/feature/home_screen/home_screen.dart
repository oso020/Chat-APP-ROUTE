import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/feature/home_screen/roomItem.dart';
import 'package:chat_app/feature/home_screen/view_model/home_screen_connector.dart';
import 'package:chat_app/feature/home_screen/view_model/view_model.dart';
import 'package:chat_app/feature/room_screen/room_screen.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../color_app.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeScreenConnector {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    homeViewModel.homeScreenConnector = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: Stack(
        children: [
          Container(
            color: ColorApp.whiteColor,
            height: double.infinity,
            width: double.infinity,
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
              backgroundColor: Colors.transparent,
              title: Text(
                "Chat App",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorApp.whiteColor),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, RoomScreen.routeName);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: StreamBuilder<QuerySnapshot<MyRooms>>(
                stream: DatabaseUtils.getRooms(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    var listRooms = snapshot.data!.docs.map((e) {
                      return e.data();
                    }).toList();
                    return GridView.builder(
                      itemCount: listRooms.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return RoomItem(
                          myRooms: listRooms[index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
