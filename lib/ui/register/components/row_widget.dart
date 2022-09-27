import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/widget/field.dart';
import '../../theme/app_theme.dart';

class RowWidget extends HookConsumerWidget {
  const RowWidget(
      {Key? key,
      required this.title,
      required this.controller,
      required this.onChange,
      required this.hintText,
      required this.isPassword,
      required this.isShowEye})
      : super(key: key);
  final String title;
  final TextEditingController controller;
  final Function(String) onChange;
  final String hintText;
  final bool isPassword;
  final bool isShowEye;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.h30,
          ),
          Field(
            onChanged: onChange,
            controller: controller,
            isPassword: isPassword,
            hintText: hintText,
            isShowEye: isShowEye,
            theme: theme,
          ),
        ],
      ),
    );
  }
}
