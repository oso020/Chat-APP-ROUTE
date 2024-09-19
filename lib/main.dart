import 'package:chat_app/feature/auth/login_screen.dart';
import 'package:chat_app/feature/auth/register_screen.dart';
import 'package:chat_app/feature/room_screen/room_screen.dart';
import 'package:chat_app/provider/save_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'feature/chat/chat.dart';
import 'feature/home_screen/home_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => SaveUser(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var saveUser=Provider.of<SaveUser>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
      initialRoute:saveUser.firebaseUser==null? LoginScreen.routeName:HomeScreen.routeName,
          routes: {
            RegisterScreen.routeName:(context)=>RegisterScreen(),
            LoginScreen.routeName:(context)=>LoginScreen(),
            HomeScreen.routeName:(context)=>HomeScreen(),
            RoomScreen.routeName:(context)=>RoomScreen(),
            ChatScreen.routeName:(context)=>ChatScreen(),
          },
        );
      },
    );
  }
}
