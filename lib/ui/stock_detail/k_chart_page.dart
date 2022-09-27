import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../common/util/logger.dart';
import '../hot/hot_view_model.dart';
import 'stock_detail_view_model.dart';

class KChartPage extends StatefulHookConsumerWidget {
  KChartPage({Key? key, required this.ts}) : super(key: key);
  final String ts;
  @override
  KChartPageState createState() => KChartPageState();
}

class KChartPageState extends ConsumerState<KChartPage> with LoggerMixin {
  @override
  void initState() {
    super.initState();
  }

  ChartStyle chartStyle = ChartStyle();

  ChartColors chartColors = ChartColors();
  @override
  Widget build(BuildContext context) {
    print("kline ts==${widget.ts}");
    chartStyle.vCrossWidth = 0.5;
    chartColors.vCrossColor = Color(0xffffffff);
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(stockDetailViewModelProvider);
    final l10n = useL10n();
    final hotState = ref.watch(hotViewModelProvider);
    // const t = {
    //   'zh_TW': ChartTranslations(
    //     date: '時間',
    //     open: '開',
    //     high: '高',
    //     low: '低',
    //     close: '收',
    //     changeAmount: '漲跌額',
    //     change: '漲跌幅',
    //     amount: '成交額',
    //   ),
    // };

    return state.stockDetailStatus == StockDetailStatus.success
        ? SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            state.changeKLineType(0);
                            hotState.nextDetailSelect(
                                "SELECT * FROM k${widget.ts} ");
                          },
                          child: Text(
                            "日",
                            style: theme.textTheme.h20.copyWith(
                                color: state.kLineType == 0
                                    ? Colors.white
                                    : Colors.white54),
                          )),
                      // Class 'String' has no instance method 'toInt'.
                      TextButton(
                          onPressed: () {
                            state.changeKLineType(1);
                            hotState.nextDetailSelect('''
select CAST(week.id as INTEGER) as id ,week.ts,week.name,week.open,week.high,week.low ,(select close from  k${widget.ts} where id=maxId )close ,week.amount,week.vo from
(select
strftime('%s',date(datetime(id, 'unixepoch'), 'weekday 0', '-7 day') )id ,
    ts,
    name,
    open,
    max(high) high,
    min(low) low,
    sum(amount) amount,
    sum(vo) vo,
    date(datetime(id, 'unixepoch'), 'weekday 0', '-7 day')WeekStart,
    max(date(datetime(id, 'unixepoch'), 'weekday 0', '-1 day')) WeekEnd,
    max(id) maxId,
    strftime('%Y', datetime(id, 'unixepoch'))  as y,
    strftime('%W',  datetime(id, 'unixepoch')) WeekNumber,
    strftime('%Y-%m-%d', datetime(id, 'unixepoch'))  as d
    from k${widget.ts} group by y,WeekNumber) week
order by id desc
''');
                          },
                          child: Text(
                            "週",
                            style: theme.textTheme.h20.copyWith(
                                color: state.kLineType == 1
                                    ? Colors.white
                                    : Colors.white54),
                          )),
                      TextButton(
                          onPressed: () {
                            state.changeKLineType(2);
                            hotState.nextDetailSelect('''
select  CAST(week.minId as INTEGER) as id ,week.ts,week.name,week.open,week.high,week.low ,(select close from  k${widget.ts} where id=minId )close ,week.amount,week.vo  from
(select
 strftime('%d-%m-%Y', datetime(min(id), 'unixepoch')) date ,
   ts,
    name,
    open,
    max(high) high,
    min(low) low,
    sum(amount) amount,
    sum(vo) vo,
   min(id) minId,
   name,
    strftime('%Y', datetime(id, 'unixepoch'))  as y,
    strftime('%W',  datetime(id, 'unixepoch')) WeekNumber,
   open,
    max(date(datetime(id, 'unixepoch'), 'weekday 0', '-1 day')) WeekEnd,
    max(high) High,
    min(low) Low,
    strftime('%m', datetime(id, 'unixepoch'))  as m, *
    from k${widget.ts} group by y,m) week

order by id desc
''');
                          },
                          child: Text(
                            "月",
                            style: theme.textTheme.h20.copyWith(
                                color: state.kLineType == 2
                                    ? Colors.white
                                    : Colors.white54),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: KChartWidget(
                    state.datas,
                    chartStyle,
                    chartColors,
                    isLine: false,
                    onSecondaryTap: () {
                      print('Secondary Tap');
                    },
                    xFrontPadding: 20,
                    isTrendLine: false,
                    mainState: MainState.MA,
                    volHidden: true,
                    secondaryState: SecondaryState.NONE,
                    fixedLength: 2,
                    timeFormat: TimeFormat.YEAR_MONTH_DAY,
                    translations: kChartTranslations,
                    showNowPrice: true,
                    //`isChinese` is Deprecated, Use `translations` instead.
                    // isChinese: false,
                    hideGrid: false,

                    isTapShowInfoDialog: false,
                    verticalTextAlignment: VerticalTextAlignment.right,
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
  }
}
