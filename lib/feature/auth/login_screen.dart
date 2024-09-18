import 'package:chat_app/color_app.dart';
import 'package:chat_app/feature/auth/register_screen.dart';
import 'package:chat_app/feature/auth/view_model/auth_connector.dart';
import 'package:chat_app/feature/auth/view_model/provider.dart';
import 'package:chat_app/widget/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../widget/TextFieldCustom.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_screen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements AuthConnector  {
  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMessage(String message,String title) {
  DialogUtils.showMessage(context: context, message: message,
  title: title,
  posAction: (){},
    posActionName: "ok"
  );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authViewModel.authConnector=this;
  }

  AuthViewModel authViewModel=AuthViewModel();
  @override
  void dispose() {
    super.dispose();
    authViewModel.userName.dispose();
    authViewModel.password.dispose();
    authViewModel.email.dispose();
    authViewModel.confirmPassword.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<AuthViewModel>(
      create: (context) =>authViewModel ,
      child: Stack(
        children: [
          Container(
            color: ColorApp.whiteColor,
          ),
          Image.asset(
            "assets/images/SIGN IN – 1.png",
            height: height,
            width: width,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorApp.whiteColor
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: authViewModel.form,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      SizedBox(
                        height: height / 4,
                      ),
                      Text("Welcome Back!",
                        style: TextStyle(
                            color: ColorApp.blackColor,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter your email";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);

                          if (!emailValid) {
                            return "enter valid email";
                          }
                          return null;
                        },
                        controller: authViewModel.emailLogin,
                        lableText: "email",
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "please enter password";
                          }

                          final bool regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(text);
                          if (!regex) {
                            return "enter valid password";
                          }
                          return null;
                        },
                        controller: authViewModel.passwordLogin,
                        obSecure: authViewModel.isSecure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            authViewModel.isSecure = !authViewModel.isSecure;
                            setState(() {});
                          },
                          icon: authViewModel.isSecure == true
                              ? Icon(Icons.visibility_off_outlined,
                            color: ColorApp.primaryColor,)
                              : Icon(Icons.visibility_outlined,
                            color: ColorApp.primaryColor,),
                        ),
                        lableText: "password",
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      InkWell(
                        onTap: (){
                        },
                        child: Text("Forget password?",
                          style: TextStyle(
                            color: ColorApp.grayColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical:25.h,horizontal:8.w  ),
                        padding: EdgeInsets.all(20),
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: ColorApp.primaryColor     , // Background color
borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Login",
                            style: TextStyle(
                              color: ColorApp.whiteColor,

                            ),
                            ),

                            IconButton(onPressed: (){
                              if (authViewModel.form.currentState!.validate()) {
                                authViewModel.loginFirebaseAuth();
                              }
                            }, icon: Icon(Icons.arrow_forward,
                            color: ColorApp.whiteColor,
                            ))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                        },
                        child: Text("Or Create My Account",
                          style: TextStyle(
                              color: ColorApp.grayColor,
                              fontSize: 14.sp,
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



}
