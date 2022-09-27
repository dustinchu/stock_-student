import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../stock_detail_view_model.dart';

class KChartTab extends HookConsumerWidget {
  KChartTab(
      {Key? key,
      required this.tabWidgets,
      required this.tabs,
      required this.len})
      : super(key: key);
  List<Widget> tabWidgets;
  List<Widget> tabs;
  int len;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(stockDetailViewModelProvider);
    final l10n = useL10n();

    return DefaultTabController(
      length: len,
      initialIndex: 0,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                border: Border(
                    bottom: BorderSide(
                        color: Colors.white.withOpacity(0.1), width: 2.sp)),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                tabs: tabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: tabWidgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
