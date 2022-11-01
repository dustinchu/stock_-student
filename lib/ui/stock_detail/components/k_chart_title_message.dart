import 'package:flapp/common/widget/line.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../stock_detail_view_model.dart';

class KChartTitleMessage extends HookConsumerWidget {
  KChartTitleMessage(
      {Key? key,
      required this.id,
      required this.name,
      required this.close,
      required this.vo,
      required this.vo2,
      required this.amount,
      required this.date})
      : super(key: key);
  String id, name, close, vo, vo2, amount, date;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(stockDetailViewModelProvider);
    final l10n = useL10n();

    Widget widgetCommonHeight(Widget _child) {
      return Container(
        alignment: Alignment.center,
        height: 35,
        child: _child,
      );
    }

    Color valueColor(double _value) {
      if (_value == .0) {
        return Colors.white;
      } else if (_value > .0) {
        return theme.appColors.red;
      } else {
        return theme.appColors.green;
      }
    }

    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000);

    var d = DateFormat('yyyy/MM/dd').format(dt);
    String deleteZero(String text) {
      String d = text.substring(text.length - 2);
      if (d == ".0") {
        return text.substring(0, text.length - 2);
      } else {
        return text;
      }
    }

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.textTheme.h30),
                  Text(id, style: theme.textTheme.h20),
                ],
              ),
            ),
            line(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    close,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  widgetCommonHeight(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            vo,
                            style: theme.textTheme.h10.copyWith(
                                height: 1.0,
                                color: valueColor(double.parse(vo))),
                          ),
                        ),
                        Text(
                          "($vo2%)",
                          style: theme.textTheme.h10.copyWith(
                              height: 1.0,
                              color: valueColor(double.parse(vo2))),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  widgetCommonHeight(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "日期:  ",
                              style: theme.textTheme.h10.copyWith(
                                height: 1.0,
                              ),
                            ),
                            Text(
                              d,
                              style: theme.textTheme.h10.copyWith(
                                  height: 1, color: Color(0xff4c5c74)),
                            ),
                          ],
                        ),
                        Text(
                          "總量:  ${deleteZero(amount)}",
                          style: theme.textTheme.h10.copyWith(height: 1.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
