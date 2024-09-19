import 'package:chat_app/color_app.dart';
import 'package:chat_app/feature/auth/view_model/auth_connector.dart';
import 'package:chat_app/feature/auth/view_model/provider.dart';
import 'package:chat_app/feature/home_screen/home_screen.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/widget/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/save_user.dart';
import '../../widget/TextFieldCustom.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_screen";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements AuthConnector {
  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMessage(String message, String title, String actionButtonName,
      [MyUser? user]) {
    var userProvider=Provider.of<SaveUser>(context,listen: false);
    userProvider.myUser=user;
    DialogUtils.showMessage(
        context: context,
        message: message,
        title: title,
        posAction: () {
          if (actionButtonName == "ok") {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          }
        },
        posActionName: actionButtonName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authViewModel.authConnector = this;
  }

  AuthViewModel authViewModel = AuthViewModel();
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
      create: (context) => authViewModel,
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
              foregroundColor: ColorApp.whiteColor,
              backgroundColor: Colors.transparent,
              title: Text(
                "Create Account",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorApp.whiteColor),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: authViewModel.form,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: height / 7,
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter your firstName";
                          }
                          return null;
                        },
                        controller: authViewModel.firstName,
                        lableText: "firstName",
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter your lastName";
                          }
                          return null;
                        },
                        controller: authViewModel.lastName,
                        lableText: "lastName",
                      ),
                      Textfieldcustom(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "enter your userName";
                          }
                          return null;
                        },
                        controller: authViewModel.userName,
                        lableText: "user",
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
                        controller: authViewModel.email,
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
                        controller: authViewModel.password,
                        obSecure: authViewModel.isSecure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            authViewModel.isSecure = !authViewModel.isSecure;
                            setState(() {});
                          },
                          icon: authViewModel.isSecure == true
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: ColorApp.primaryColor,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  color: ColorApp.primaryColor,
                                ),
                        ),
                        lableText: "password",
                      ),
                      Textfieldcustom(
                        obSecure: authViewModel.isSecureConfirm,
                        suffixIcon: IconButton(
                          onPressed: () {
                            authViewModel.isSecureConfirm =
                                !authViewModel.isSecureConfirm;
                            setState(() {});
                          },
                          icon: authViewModel.isSecureConfirm == true
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: ColorApp.primaryColor,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  color: ColorApp.primaryColor,
                                ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "please enter confirm password";
                          }
                          if (text != authViewModel.password.text) {
                            return "password dont match";
                          }
                          return null;
                        },
                        controller: authViewModel.confirmPassword,
                        lableText: "confirm password",
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 50.h, horizontal: 8.w),
                        padding: EdgeInsets.all(20),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ColorApp.whiteColor, // Background color

                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.5), // Shadow color with opacity
                              spreadRadius: 3, // Spread radius of the shadow
                              blurRadius: 2, // Blur radius of the shadow
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Account",
                              style: TextStyle(
                                color: ColorApp.grayColor,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (authViewModel.form.currentState!
                                      .validate()) {
                                    authViewModel.registerFirebaseAuth();
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: ColorApp.grayColor,
                                ))
                          ],
                        ),
                      )
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
