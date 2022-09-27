import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/list_card.dart';
import 'hot_view_model.dart';

class Tab1Page extends StatefulHookConsumerWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  Tab1PageState createState() => Tab1PageState();
}

class Tab1PageState extends ConsumerState<Tab1Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(hotViewModelProvider).hotData(
          "select * from home where id =1640793600 order by amount desc limit 20",
          1);
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
      tabIndex: 1,
    ));
  }
}
