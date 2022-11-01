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

    String deleteZero(String text) {
      String d = text.substring(text.length - 2);
      if (d == ".0") {
        return isInt(text.substring(0, text.length - 2));
      } else {
        return isInt(text);
      }
    }

    List<DataCell> getDataCell(int index) {
      List<DataCell> result = [];
      // if (index == 0) {
      //   result.add(DataCell(Text("股票名稱")));
      //   if (state.saveIndex == 1) {
      //     result.add(DataCell(Text(state.dbResult1[0]["name"].toString())));
      //   } else if (state.saveIndex == 2) {
      //     result.add(DataCell(Text(state.dbResult1[0]["name"].toString())));
      //     result.add(DataCell(Text(state.dbResult2[0]["name"].toString())));
      //   } else if (state.saveIndex == 3) {
      //     result.add(DataCell(Text(state.dbResult1[0]["name"].toString())));
      //     result.add(DataCell(Text(state.dbResult2[0]["name"].toString())));
      //     result.add(DataCell(Text(state.dbResult3[0]["name"].toString())));
      //   }
      // } else {
      result.add(DataCell(Text(
          "${state.dbResult1[index]["year"].toString()}Q${state.dbResult1[index]["month"].toString()}")));
      if (state.saveIndex == 1) {
        result.add(DataCell(Text(deleteZero(
            state.dbResult1[index][state.sqlTitleName].toString()))));
      } else if (state.saveIndex == 2) {
        result.add(DataCell(Text(deleteZero(
            state.dbResult1[index][state.sqlTitleName].toString()))));
        result.add(DataCell(Text(deleteZero(
            state.dbResult2[index][state.sqlTitleName].toString()))));
      } else if (state.saveIndex == 3) {
        result.add(DataCell(Text(deleteZero(
            state.dbResult1[index][state.sqlTitleName].toString()))));
        result.add(DataCell(Text(deleteZero(
            state.dbResult2[index][state.sqlTitleName].toString()))));
        result.add(DataCell(Text(deleteZero(
            state.dbResult3[index][state.sqlTitleName].toString()))));
      }
      // }

      return result;
    }

    Widget dataTable() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
            columnSpacing: state.saveIndex.toDouble(),
            horizontalMargin: 20,
            minWidth: 200,
            columns: state.getDataTable(),
            rows: List<DataRow>.generate(
                36, (index) => DataRow(cells: getDataCell(index)))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${state.detailTitleName} ${state.detailBodyName} ${state.titleType == 1 ? "(千)" : ""}"),
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
                          ? "${state.dbResult1[0]["ts"].toString()} ${state.dbResult1[0]["name"].toString()}"
                          : i == 1
                              ? "${state.dbResult2[0]["ts"].toString()} ${state.dbResult2[0]["name"].toString()}"
                              : "${state.dbResult3[0]["ts"].toString()} ${state.dbResult3[0]["name"].toString()}"),
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
