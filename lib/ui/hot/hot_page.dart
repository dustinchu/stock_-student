import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'hot_view_model.dart';
import 'tab1_page.dart';
import 'tab2_page.dart';
import 'tab3_page.dart';

class HotPage extends HookConsumerWidget {
  const HotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(hotViewModelProvider);
    final l10n = useL10n();
// : initialDate 2022-09-22 00:00:00.000 must be on or before lastDate 2021-12-30 00:00:00.000.
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("熱門排行"),
            Text(state.hotDate),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                DateTime tempDate =
                    DateFormat('yyyy-MM-dd').parse("2022-12-30");
                DateTime? dt = await showDatePicker(
                  context: context,
                  initialDate: tempDate,
                  firstDate: DateTime(2018, 01, 02),
                  lastDate: DateTime(2022, 12, 31),
                  // selectableDayPredicate: (dt) {
                  //   state.selectDate(dt);
                  // },
                );
                if (dt != null) {
                  state.selectDate(dt);
                }
                // state.testDate();
              },
              icon: Icon(Icons.date_range))
        ],
      ),
      body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const TabBar(
                  // isScrollable: true,
                  automaticIndicatorColorAdjustment: false,
                  // labelColor: Color(
                  tabs: [
                    Tab(
                      text: "成交量",
                    ),
                    Tab(
                      text: "漲幅",
                    ),
                    Tab(
                      text: "跌幅",
                    ),
                  ],
                ),
                const Expanded(
                    child: TabBarView(children: <Widget>[
                  Tab1Page(),
                  Tab2Page(),
                  Tab3Page(),
                ]))
              ])),
    );
  }
}
