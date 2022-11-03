import 'dart:io';

import 'package:dei/features/dashboard/presentation/widget_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static void showLoaderDialog(BuildContext context,
      {String? imagePath, bool fromNetwork = false}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        if (imagePath != null) {
          return gifLoader(imagePath: imagePath, fromNetwork: fromNetwork);
        }
        return dialogLoader();
      },
    );
  }

  void dismiss(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<dynamic> notificationDialog(BuildContext context) {
    return showDialog(
        barrierColor: Colors.white60,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0.5),
            content: Card(
              elevation: 20.0,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                color: Colors.white,
                height: 100,
                width: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/notification.png')),
                        horizontalSpace(40.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From: Team Leader - John Doe'),
                            verticalSpace(10.0),
                            Container(
                                width: 400.0,
                                height: 40.0,
                                child: Text(
                                  'You have achieved your daily target of 375 photographs. You are a star. Keep up the good work!',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text('Mark as Read'),
                        horizontalSpace(40.0),
                        Image(image: AssetImage('assets/images/trash.png')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static Future<dynamic> showAlertDialog(
      BuildContext context, String title, String content,
      {String buttonText = "OK",
      Function()? onTap,
      bool isDismissible = true}) {
    Widget okButton = TextButton(
      child: Text(buttonText),
      onPressed: onTap ??
          () {
            Navigator.of(context).pop();
          },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return showCupertinoDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(buttonText),
            onPressed: onTap ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        ],
      ),
    );
  }

  static Future<dynamic> showConfirmAlertDialog(
      BuildContext context, String title, String content,
      {String optionButtonText = "OK",
      required Function() onOptionTap,
      String cancelButtonText = "Cancel",
      Function()? onCancelTap,
      bool isDismissible = true}) {
    Widget cancelButton = TextButton(
      child: Text(cancelButtonText),
      onPressed: onCancelTap ??
          () {
            Navigator.of(context).pop();
          },
    );
    Widget optionButton = TextButton(
      child: Text(optionButtonText),
      onPressed: onOptionTap,
    );

    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[cancelButton, optionButton],
          );
        },
      );
    }

    return showCupertinoDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(cancelButtonText),
            onPressed: onCancelTap ?? () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            child: Text(optionButtonText),
            onPressed: onOptionTap,
          ),
        ],
      ),
    );
  }

  static Widget loader() {
    return Center(
        child: Platform.isIOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator());
  }

  static Widget dialogLoader() {
    return Center(
        child: Platform.isIOS
            ? CupertinoActivityIndicator(radius: 12)
            : CircularProgressIndicator());
  }

  static Widget gifLoader(
      {required String imagePath, bool fromNetwork = false}) {
    if (fromNetwork) {
      return Center(child: Image.network(imagePath));
    }
    return Center(
      child: Image.asset(imagePath),
    );
  }
}
