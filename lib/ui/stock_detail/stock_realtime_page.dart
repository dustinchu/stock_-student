import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/stock_detail/components/realtime_chart.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/detail_message.dart';
import 'stock_detail_view_model.dart';

class StockRealtimePage extends HookConsumerWidget {
  const StockRealtimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(stockDetailViewModelProvider);
    final l10n = useL10n();

    return Scaffold(
        body: Column(
      children: [
        RealtimeChart(),
        DetailMessage(),
      ],
    ));
  }
}
