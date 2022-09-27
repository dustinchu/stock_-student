import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/stock_detail/components/row_data.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../stock_detail_view_model.dart';

class DetailMessage extends HookConsumerWidget {
  const DetailMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(stockDetailViewModelProvider);
    final l10n = useL10n();
    List<String> leftTitle = ["開盤", "最高", "買價", "買量", "內盤", "金額(億）"];
    List<String> rightTitle = ["振福", "˙最低", "賣價", "賣量", "外盤", "昨收"];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          for (var i = 0; i < leftTitle.length; i++)
            RowData(
                leftTitle: leftTitle[i],
                leftValue: "56.6",
                leftColor: theme.appColors.green,
                rightTitle: rightTitle[i],
                rightValue: "9.53%",
                rightColor: Colors.white,
                isBackround: false),
        ],
      ),
    );
  }
}
