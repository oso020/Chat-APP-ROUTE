import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SaveUser extends ChangeNotifier{
  MyUser? myUser;
  User? firebaseUser;

  SaveUser(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  void initUser() async{
    if(firebaseUser !=null){
      myUser =await DatabaseUtils.getUser(firebaseUser!.uid);
    }
  }
}