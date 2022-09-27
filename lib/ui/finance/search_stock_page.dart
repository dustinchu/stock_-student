import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../hot/components/list_card.dart';
import '../hot/hot_view_model.dart';

class SearchStockPag extends StatefulHookConsumerWidget {
  SearchStockPag({Key? key, required this.pageRoute}) : super(key: key);
  String pageRoute;
  @override
  SearchStockPageState createState() => SearchStockPageState();
}

class SearchStockPageState extends ConsumerState<SearchStockPag> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.pageRoute == "stock") {
        ref.read(hotViewModelProvider).allData(
            "select * from home   where id =1640793600 ", widget.pageRoute);
      } else {
        ref.read(hotViewModelProvider).clean(widget.pageRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(hotViewModelProvider);
    final l10n = useL10n();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageRoute == "stock" ? "上市股票" : "財務狀況"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListCard(
        pageRoute: widget.pageRoute,
        isSearch: true,
        tabIndex: 0,
      )),
    );
  }
}
