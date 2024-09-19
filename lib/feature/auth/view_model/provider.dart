import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/feature/auth/view_model/auth_connector.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier{
  bool isSecure = true;
  bool isSecureConfirm = true;
  final form = GlobalKey<FormState>();
late AuthConnector authConnector;
  TextEditingController firstName = TextEditingController(text: "mohamed");
  TextEditingController lastName = TextEditingController(text: "osman");
  TextEditingController userName = TextEditingController(text: "Mohamed osman");
  TextEditingController email = TextEditingController(text:"osman54@gmail.com" );
  TextEditingController password = TextEditingController(text: "Mm#123456");
  TextEditingController confirmPassword = TextEditingController(text: "Mm#123456");

  TextEditingController emailLogin = TextEditingController(text:"osman54@gmail.com" );
  TextEditingController passwordLogin = TextEditingController(text: "Mm#123456");
 Future<void> registerFirebaseAuth() async {
    authConnector.showLoading("Loading...");
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      MyUser user=MyUser(
          id: credential.user!.uid,
          firstName: firstName.text,
          lastName: lastName.text,
          userName: userName.text,
          email: email.text);
      await DatabaseUtils.registerUser(user);
      authConnector.hideLoading();
      authConnector.showMessage("Register Successfully","Success","ok");


    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        authConnector.hideLoading();
        authConnector.showMessage("invalid-credential","fail",'try again');
      } else if (e.code == 'email-already-in-use') {
        authConnector.hideLoading();
        authConnector.showMessage("email-already-in-use","fail",'try again');
      } else if (e.code == 'network-request-failed') {
        authConnector.hideLoading();
        authConnector.showMessage("network-request-failed","fail",'try again');
      }
    } catch (e) {
      authConnector.hideLoading();
      authConnector.showMessage(e.toString(),"fail",'try again');
    }
  }

  Future<void>  loginFirebaseAuth() async {
    authConnector.showLoading("Loading...");

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLogin.text, password: passwordLogin.text);

      var userObj=await DatabaseUtils.getUser(credential.user!.uid);
      if(userObj == null){
        authConnector.hideLoading();
        authConnector.showMessage("Register failed","fail","try again");
      }else{
        authConnector.hideLoading();
        authConnector.showMessage("Login Successfully","Success","ok",userObj);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        authConnector.hideLoading();
        authConnector.showMessage("invalid-credential","fail",'try again');
      } else if (e.code == 'network-request-failed') {
        authConnector.hideLoading();
        authConnector.showMessage("network-request-failed","fail",'try again');
      }
    } catch (e) {
      authConnector.hideLoading();
      authConnector.showMessage(e.toString(),"fail",'try again');
    }
  }

}