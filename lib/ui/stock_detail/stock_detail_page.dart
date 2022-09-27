import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/widget/line.dart';
import 'components/k_chart_tab.dart';
import 'components/k_chart_title_message.dart';
import 'k_chart_page.dart';
import 'stock_detail_view_model.dart';

class StockDetailPage extends HookConsumerWidget {
  StockDetailPage(
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
//     # 股票代號	股票名稱	營業利益率(%)	存貨週轉率(次)	       毛利率(%)	稅後純益率(%)	    原始每股營業額(元)
// # ts	    name	operatingMargin	inventoryTurnover	grossMargin	 profitMargin(%)	turnover

    // double w = MediaQuery.of(context).size.width - 3.h;
    // List<double> rowW = [(w / 4) * 2, (w / 4)];
    Widget tab(String text) {
      return SizedBox(
        height: 30,
        child: Tab(
          text: text,
        ),
      );
    }

    Widget loading() {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("個股明細"),
      ),
      body: Column(children: [
        KChartTitleMessage(
          id: id,
          name: name,
          close: close,
          vo: vo,
          vo2: vo2,
          date: date,
          amount: amount,
        ),
        marginLine(),
        KChartTab(
          len: 1,
          // tabs: [tab("即時"), tab("K線"), tab("財務")],
          // tabs: [tab("即時"), tab("K線")],
          tabs: [tab("K線")],
          tabWidgets: [
            // state.stockDetailStatus == StockDetailStatus.success
            //     ? const StockRealtimePage()
            //     : loading(),
            state.stockDetailStatus == StockDetailStatus.success
                ? KChartPage(ts: id)
                : loading(),
            // state.stockDetailStatus == StockDetailStatus.success
            //     ? FinancePage(
            //         rowData: rowData,
            //       )
            //     : loading(),
          ],
        ),
      ]),
    );
  }
}
