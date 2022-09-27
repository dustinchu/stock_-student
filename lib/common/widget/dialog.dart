import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ui/routes/app_route.gr.dart';

nextUntilPage(BuildContext context, PageRouteInfo pageRoute) {
  AutoRouter.of(context).pushAndPopUntil(pageRoute, predicate: (_) => false);
}

void dialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          "尚未登入",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "登入帳戶可以跨裝置同步自選股，並自訂自己的投資組合",
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        actions: [
          CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text(
                "取消",
              ),
              onPressed: () async {
                Navigator.pop(context);
              }),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text(
              "登入",
            ),
            onPressed: () async {
              Navigator.pop(context);
              nextUntilPage(context, const LoginRoute());
            },
          ),
        ],
      );
    },
  );
}

Widget msgDialog(BuildContext context, String title, String body) {
  return CupertinoAlertDialog(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        body,
        style: TextStyle(fontSize: 16.sp),
      ),
    ),
    actions: [
      CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text(
            "關閉",
          ),
          onPressed: () async {
            Navigator.pop(context);
          }),
    ],
  );
}
