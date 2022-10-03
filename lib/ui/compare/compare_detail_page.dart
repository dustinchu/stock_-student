import 'package:data_table_2/data_table_2.dart';
import 'package:flapp/ui/compare/util/chart_color.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'compare_view_model.dart';
import 'components/chart.dart';

class CompareDetailPage extends StatefulHookConsumerWidget {
  const CompareDetailPage({Key? key}) : super(key: key);

  @override
  ComparePageState createState() => ComparePageState();
}

class ComparePageState extends ConsumerState<CompareDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(compareViewModelProvider);
    final l10n = useL10n();

    String isInt(String s) {
      if (s.toString().length > 4) {
        var format = NumberFormat('0,000');
        return format.format(double.parse(s));
      }
      return s;
    }

    List<DataCell> getDataCell(int index) {
      List<DataCell> result = [];

      if (index == 0) {
        result.add(DataCell(Text(state.getTs(state.textController1.text))));
        result.add(DataCell(Text(state.dbResult1[0]["name"].toString())));
        for (Map<String, Object?> r in state.dbResult1) {
          result.add(DataCell(Text(isInt(r[state.sqlTitleName].toString()))));
        }
      }
      if (index == 1) {
        result.add(DataCell(Text(state.getTs(state.textController2.text))));
        result.add(DataCell(Text(state.dbResult2[0]["name"].toString())));
        for (Map<String, Object?> r in state.dbResult2) {
          result.add(DataCell(Text(isInt(r[state.sqlTitleName].toString()))));
        }
      }
      if (index == 2) {
        result.add(DataCell(Text(state.getTs(state.textController3.text))));
        result.add(DataCell(Text(state.dbResult3[0]["name"].toString())));
        for (Map<String, Object?> r in state.dbResult3) {
          result.add(DataCell(Text(isInt(r[state.sqlTitleName].toString()))));
        }
      }
      return result;
    }

    Widget dataTable() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 20,
            minWidth: 3700,
            columns: state.getDataTable(),
            rows: List<DataRow>.generate(state.saveIndex,
                (index) => DataRow(cells: getDataCell(index)))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("兩股比較"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = 0; i < state.saveIndex; i++)
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        color: chartColor[i],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(i == 0
                          ? state.textController1.text
                          : i == 1
                              ? state.textController2.text
                              : state.textController3.text),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
              ],
            ),
          ),
          const LineChartS(),
          Expanded(child: dataTable()),
        ],
      ),
    );
  }
}
