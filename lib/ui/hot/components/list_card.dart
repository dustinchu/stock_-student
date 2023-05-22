import 'package:auto_route/auto_route.dart';
import 'package:flapp/common/util/random.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/util/str_format.dart';
import '../../../common/widget/field.dart';
import '../../routes/app_route.gr.dart';
import '../hot_view_model.dart';
import 'percentagRow.dart';

class ListCard extends HookConsumerWidget {
  ListCard(
      {Key? key,
      required this.isSearch,
      required this.pageRoute,
      required this.tabIndex})
      : super(key: key);
  bool isSearch;
  String pageRoute;
  int tabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(hotViewModelProvider);
    double w = MediaQuery.of(context).size.width;

    Widget container(List<Widget> _widget, double _w) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        width: _w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _widget,
        ),
      );
    }

    Widget row1(double _w, String title, String body) {
      return container([
        Text(
          title,
          style: theme.textTheme.h10,
        ),
        Text(
          body,
          style: theme.textTheme.h10,
        )
      ], _w);
    }

    Widget row2(double _w, String title, String body, bool isHight) {
      return container([
        Text(
          title,
          style: theme.textTheme.h10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "總量 ",
              style: theme.textTheme.h10.copyWith(color: Colors.white54),
            ),
            Text(
              body,
              style: theme.textTheme.h10,
            ),
          ],
        )
      ], _w);
    }

    Widget row3(double _w, String title, String body, List<double> percentage,
        bool isHight) {
      return container([
        Row(
          children: [
            Icon(
              isHight ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
              size: 20,
              color: isHight ? theme.appColors.red : theme.appColors.green,
            ),
            Text(
              title,
              style: theme.textTheme.h10.copyWith(
                  color: isHight ? theme.appColors.red : theme.appColors.green),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 25.w,
              child: Row(
                children: [
                  Text(
                    "單量 ",
                    style: theme.textTheme.h10.copyWith(color: Colors.white54),
                  ),
                  Text(
                    body,
                    style: theme.textTheme.h10.copyWith(),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: 7.w,
              child: PercentageRow(
                percentages: percentage,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.1.h),
                    height: 1.1.h,
                    color: theme.appColors.red,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.1.h),
                    height: 1.1.h,
                    color: theme.appColors.green,
                  ),
                ],
              ),
            )
          ],
        )
      ], _w);
    }

    double widgetWidth = (w - 5.w - 70) / 3;
    double widgetWidth2 = (w - 5.w - 70) / 4;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Column(
        children: [
          isSearch
              ? Field(
                  onChanged: (text) {
                    // state.emailValidation(text)
                  },
                  controller: state.textEditingController,
                  isPassword: false,
                  hintText: "搜尋",
                  theme: theme,
                  isShowEye: false,
                )
              : Container(),
          Expanded(
            child: ListView.separated(
              itemCount: state.stockList == null ? 0 : state.stockList.length,
              itemBuilder: (context, index) {
                double percentageValue = getDoubleRandom();
                if (percentageValue == 0.0) percentageValue = 0.1;
                return InkWell(
                  // onTap: () =>
                  //     AutoRouter.of(context).pushNamed(RoutePath.stockDetailPage),
                  // finance
                  onTap: () {
                    String ts = state.stockList[index]["ts"].toString();
                    if (pageRoute == "finance") {
                      AutoRouter.of(context).push(FinanceRoute(
                          ts: state.stockList[index]["ts"].toString()));
                    } else {
                      state.nextDetailSelect(
                          "SELECT * FROM k$ts order by id desc");
                      AutoRouter.of(context).push(StockDetailRoute(
                          id: ts,
                          name: state.stockList[index]["name"].toString(),
                          close: state.stockList[index]["close"].toString(),
                          vo: state.stockList[index]["vo"].toString(),
                          vo2: state.stockList[index]["vo2"].toString(),
                          amount: state.stockList[index]["amount"].toString(),
                          date: state.stockList[index]["id"].toString()));
                    }
                  },
                  child: Row(children: [
                    pageRoute != "stock"
                        ? pageRoute != "finance"
                            ? Text(pageRoute == "hot"
                                ? (index + 1).toString()
                                : index.toString())
                            : Container()
                        : Container(),
                    const SizedBox(
                      width: 10,
                    ),
                    row1(
                        widgetWidth2 - 20,
                        state.stockList[index]["name"].toString(),
                        state.stockList[index]["ts"].toString()),
                    row2(
                        widgetWidth2 + 30,
                        state.stockList[index]["close"].toString(),
                        getFormatStepCount(
                                state.stockList[index]["amount"].toString())
                            .toString(),
                        double.parse(state.stockList[index]["vo"].toString()) >
                            0),
                    row3(
                        widgetWidth + 30,
                        "${state.stockList[index]["vo"].toString()}(${state.stockList[index]["vo2"].toString()}%)",
                        getFormatStepCount(state.stockList[index]
                                    ["one_quantity"]
                                .toString())
                            .toString(),
                        [0.7, 0.3],
                        double.parse(state.stockList[index]["vo"].toString()) >
                            0),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          state.savaStock(
                              context,
                              int.parse(
                                  state.stockList[index]["ts"].toString()),
                              state.stockList[index]["sava_status"]
                                          .toString() ==
                                      "0"
                                  ? "1"
                                  : "0",
                              tabIndex);
                        },
                        icon: Icon(
                            state.stockList[index]["sava_status"].toString() ==
                                    "0"
                                ? Icons.star_border
                                : Icons.star))
                  ]),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
