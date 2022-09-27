import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/widget/line.dart';
import '../../theme/app_theme.dart';

class RowData extends HookConsumerWidget {
  const RowData(
      {Key? key,
      required this.leftTitle,
      required this.leftValue,
      required this.leftColor,
      required this.rightTitle,
      required this.rightValue,
      required this.rightColor,
      required this.isBackround})
      : super(key: key);
  final String leftTitle;
  final String leftValue;
  final Color leftColor;
  final String rightTitle;
  final String rightValue;
  final Color rightColor;
  final bool isBackround;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      leftTitle,
                      style:
                          theme.textTheme.h20.copyWith(color: Colors.white54),
                    ),
                    Text(
                      leftValue,
                      style: theme.textTheme.h20.copyWith(color: leftColor),
                    )
                  ],
                ),
                line()
              ],
            )),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rightTitle,
                      style:
                          theme.textTheme.h20.copyWith(color: Colors.white54),
                    ),
                    isBackround
                        ? Container(
                            color: rightColor,
                            child: Text(rightValue, style: theme.textTheme.h20),
                          )
                        : Text(rightValue, style: theme.textTheme.h20),
                  ],
                ),
                line()
              ],
            ))
          ],
        ),
      ],
    );
  }
}
