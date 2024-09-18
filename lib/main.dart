import 'package:chat_app/feature/auth/login_screen.dart';
import 'package:chat_app/feature/auth/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
          routes: {
            RegisterScreen.routeName:(context)=>RegisterScreen(),
            LoginScreen.routeName:(context)=>LoginScreen()
          },
        );
      },
    );
  }
}
