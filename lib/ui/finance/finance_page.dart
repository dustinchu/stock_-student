import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'finance_view_model.dart';

List<List<String>> rowData = [
  [
    "獲利能力",
    "2022Q1",
    "2022Q2",
  ],
  [
    "營業毛利率",
    "37.81%",
    "28.95",
  ],
  [
    "營業利益率",
    "-94.61%",
    "-108.77%",
  ],
  [
    "舉債成本",
    "0.43",
    "0.43",
  ],
  [
    "稅後淨利率",
    "-68.44%",
    "-88.34%",
  ],
  [
    "每股營收",
    "1.34",
    "1.44",
  ],
  [
    "每股盈餘\n按加權平均股數計算",
    "-0.92",
    "-1.25",
  ],
  [
    "股東權益報酬率\n稅後",
    "-2.77%",
    "-3.52%",
  ],
  [
    "資產報酬率",
    "-1.64%",
    "-2.30%",
  ],
  [
    "經營能力",
    "2022Q1",
    "2022Q1",
  ],
  [
    "總資產週轉率",
    "0.02",
    "0.03",
  ],
  [
    "淨值週轉率",
    "0.04",
    "0.04",
  ],
  [
    "季營收年增率",
    "-6.04%",
    "-11.63%",
  ],
  [
    "償還能力",
    "2022Q1",
    "2022Q2",
  ],
  [
    "應收款項週轉率",
    "2.71",
    "3.05",
  ],
  [
    "存貨週轉率",
    "0.40",
    "0.54",
  ]
];

class FinancePage extends StatefulHookConsumerWidget {
  FinancePage({
    required this.ts,
    Key? key,
  }) : super(key: key);
  String ts;

  @override
  FinancePageState createState() => FinancePageState();
}

class FinancePageState extends ConsumerState<FinancePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(financeViewModelProvider).init(widget.ts);
    });
  }

  List<DropdownMenuItem<String>> subrouteNameMenuItems = const [
    DropdownMenuItem(value: '2022', child: Text('2022')),
    DropdownMenuItem(value: '2021', child: Text('2021')),
    DropdownMenuItem(value: '2020', child: Text('2020')),
    DropdownMenuItem(value: '2019', child: Text('2019')),
    DropdownMenuItem(value: '2018', child: Text('2018')),
    DropdownMenuItem(value: '2017', child: Text('2017')),
    DropdownMenuItem(value: '2016', child: Text('2016')),
    DropdownMenuItem(value: '2015', child: Text('2015')),
    DropdownMenuItem(value: '2014', child: Text('2014')),
    DropdownMenuItem(value: '2013', child: Text('2013')),
  ];
  String selectedSort = '2022';
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(financeViewModelProvider);
    final l10n = useL10n();

    Widget rowWidget(
        bool isTitle, String row1Text, String row2Text, String roe3Text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: isTitle ? 1.h : 0),
        height: 30,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                row1Text,
                style: isTitle
                    ? theme.textTheme.h20
                        .copyWith(color: Color.fromARGB(80, 255, 255, 255))
                    : theme.textTheme.h30
                        .copyWith(color: Color.fromARGB(80, 255, 255, 255)),
              ),
            ),
            Expanded(
                flex: 1,
                child: Text(row2Text,
                    style: isTitle
                        ? theme.textTheme.h20
                            .copyWith(color: Color.fromARGB(80, 255, 255, 255))
                        : theme.textTheme.h20.copyWith(color: Colors.white))),
            Expanded(
                flex: 1,
                child: Text(roe3Text,
                    style: isTitle
                        ? theme.textTheme.h20
                            .copyWith(color: Color.fromARGB(56, 255, 255, 255))
                        : theme.textTheme.h20.copyWith(color: Colors.white))),
          ],
        ),
      );
    }

    Widget msg(String l, String r, String s) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(children: [
          Expanded(flex: 2, child: Text(l, style: TextStyle(fontSize: 20))),
          Expanded(
              child: Text(state.stockList[0][r].toString() + s,
                  style: TextStyle(fontSize: 20)))
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("財報"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  child: Text(
                    "${state.stockList.isEmpty ? "" : state.stockList[0]["name"]}  ${state.stockList.isEmpty ? "" : state.stockList[0]["ts"]}\n近期財報 ${state.stockList.isEmpty ? "2021" : state.stockList[0]["id"]}",
                    style: theme.textTheme.h40,
                  ),
                ),
                DropdownButton(
                    value: state.stockList.isEmpty
                        ? "2022"
                        : state.stockList[0]["id"],
                    items: subrouteNameMenuItems,
                    onChanged: (v) {
                      state.selectYear(widget.ts, v.toString());
                    }),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.stockList.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            msg("資產報酬率(%)", "roa", "%"),
                            SizedBox(height: 1.h),
                            msg("總資產週轉率(次)", "total_asset_turmover", ""),
                            SizedBox(height: 1.h),
                            msg("權益報酬率(%)", "Roe", "%"),
                            SizedBox(height: 1.h),
                            msg("存貨週轉率(次)", "Inventory_turnover", ""),
                            SizedBox(height: 1.h),
                            msg("應收款項週轉率(次)", "receivable_turnover", ""),
                            SizedBox(height: 1.h),
                            msg("負債比率(%)", "debt_ratio", "%"),
                            SizedBox(height: 1.h),
                            msg("流動比率(%)", "current_ratio", "%"),
                            SizedBox(height: 1.h),
                            msg("速動比率(%)", "quick_ratio", "%"),
                            SizedBox(height: 1.h),
                            msg("每股盈餘(元)", "eps", ""),
                            SizedBox(height: 1.h),
                            msg("現金流量比率(%)", "cash_flow_ratio", "%"),
                            SizedBox(height: 1.h),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
