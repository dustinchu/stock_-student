import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/list_card.dart';
import 'hot_view_model.dart';

class Tab2Page extends StatefulHookConsumerWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Tab2PageState createState() => Tab2PageState();
}

class Tab2PageState extends ConsumerState<Tab2Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(hotViewModelProvider).hotData(
          "select distinct * from home where id =1672329600  order by vo desc  limit 20",
          2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(hotViewModelProvider);
    final l10n = useL10n();

    return SafeArea(
        child: ListCard(
      pageRoute: "hot",
      isSearch: false,
      tabIndex: 2,
    ));
  }
}
