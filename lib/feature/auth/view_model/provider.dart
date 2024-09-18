import 'package:chat_app/feature/auth/view_model/auth_connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier{
  bool isSecure = true;
  bool isSecureConfirm = true;
  final form = GlobalKey<FormState>();
late AuthConnector authConnector;
  TextEditingController userName = TextEditingController(text: "osman");
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
      authConnector.hideLoading();
      authConnector.showMessage("Register Successfully","Success");


    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        authConnector.hideLoading();
        authConnector.showMessage("invalid-credential","fail");
      } else if (e.code == 'email-already-in-use') {
        authConnector.hideLoading();
        authConnector.showMessage("email-already-in-use","fail");
      } else if (e.code == 'network-request-failed') {
        authConnector.hideLoading();
        authConnector.showMessage("network-request-failed","fail");
      }
    } catch (e) {
      authConnector.hideLoading();
      authConnector.showMessage(e.toString(),"fail");
    }
  }

  Future<void>  loginFirebaseAuth() async {
    authConnector.showLoading("Loading...");

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLogin.text, password: passwordLogin.text);
      authConnector.hideLoading();
      authConnector.showMessage("Login Successfully","Success");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        authConnector.hideLoading();
        authConnector.showMessage("invalid-credential","fail");
      } else if (e.code == 'network-request-failed') {
        authConnector.hideLoading();
        authConnector.showMessage("network-request-failed","fail");
      }
    } catch (e) {
      authConnector.hideLoading();
      authConnector.showMessage(e.toString(),"fail");
    }
  }

}