import 'package:flutter/material.dart';

import '../color_app.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorApp.whiteColor,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: ColorApp.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorApp.primaryColor,
                        ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      String title = '',
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction != null){
            //   posAction.call();
            // }
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith( color: ColorApp.primaryColor,),
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: ColorApp.primaryColor,),
          )));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorApp.whiteColor,
            content: Text(message,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorApp.primaryColor,
                    )),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorApp.primaryColor,
                  ),
            ),
            actions: actions,
          );
        });
  }
}
