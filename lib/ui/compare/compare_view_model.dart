import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/service/db.dart';
import '../../common/util/logger.dart';

final compareViewModelProvider = ChangeNotifierProvider((ref) {
  final compareViewModelProvider = CompareViewModel(ref.read);
  compareViewModelProvider.init();
  return compareViewModelProvider;
});

enum CompareStatus {
  success,
  fail,
  start,
  loding,
}

class CompareViewModel extends ChangeNotifier with LoggerMixin {
  CompareViewModel(this._reader);

  final Reader _reader;

  // late final CompareRepository _repository =
  //     _reader(compareRepositoryProvider);

  //control
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  //Compare status
  CompareStatus compareStatus = CompareStatus.start;
  DB db = DB();

  String text1 = "", text2 = "", text3 = "", text4 = "", text5 = "", text6 = "";

  int titleType = 1;
  int bodyType1 = 1, bodyType2 = 1, bodyType3 = 1;
  String sqlTableName = "ci",
      sqlTitleName = "nnor",
      detailTitleName = "綜合損益項目",
      detailBodyName = "營業收入";
  List<Map<String, Object?>> dbResult1 = [];
  List<Map<String, Object?>> dbResult2 = [];
  List<Map<String, Object?>> dbResult3 = [];
  double maxY = .0, minY = .0;
  int saveIndex = 1;
  init() {
    textController1.text = "";
    textController2.text = "";
    textController3.text = "";
    sqlTableName = "ci";
    sqlTitleName = "nnor";
    bodyType1 = 999;
    titleType = 999;

    notifyListeners();
  }

  DataColumn dColumn(String text) {
    return DataColumn2(
      label: Text(text),
      size: ColumnSize.L,
    );
  }

  List<DataColumn> getDataTable() {
    print("save index ==$saveIndex");
    List<DataColumn> d = [];
    d.add(dColumn("股票代號\n股票名稱"));
    // d.add(dColumn("股票名稱"));
    if (saveIndex == 1) {
      d.add(dColumn(
          "${dbResult1[0]["ts"].toString()}\n${dbResult1[0]["name"].toString()}"));
    } else if (saveIndex == 2) {
      d.add(dColumn(
          "${dbResult1[0]["ts"].toString()}\n${dbResult1[0]["name"].toString()}"));
      d.add(dColumn(
          "${dbResult2[0]["ts"].toString()}\n${dbResult2[0]["name"].toString()}"));
    } else if (saveIndex == 3) {
      d.add(dColumn(
          "${dbResult1[0]["ts"].toString()}\n${dbResult1[0]["name"].toString()}"));
      d.add(dColumn(
          "${dbResult2[0]["ts"].toString()}\n${dbResult2[0]["name"].toString()}"));
      d.add(dColumn(
          "${dbResult3[0]["ts"].toString()}\n${dbResult3[0]["name"].toString()}"));
    }

    // for (Map<String, Object?> r in dbResult1) {
    //   d.add(dColumn("${r["year"]}Q${r["month"]}"));
    // }
    print("d len ===${d.length}");
    return d;
  }

  changeTitleType(int? i) {
    titleType = i ?? 1;
    switch (i) {
      case 1:
        detailTitleName = "綜合損益項目";
        detailBodyName = "營業收入";
        sqlTableName = "ci";
        sqlTitleName = "nnor";
        bodyType1 = 1;
        break;
      case 2:
        detailTitleName = "償債能力";
        detailBodyName = "流動比率";
        sqlTableName = "solvency";
        sqlTitleName = "cr";
        bodyType2 = 1;
        break;
      case 3:
        detailTitleName = "獲利能力";
        detailBodyName = "毛利率";
        sqlTableName = "profitability";
        sqlTitleName = "gpm";
        bodyType3 = 1;
        break;
    }

    notifyListeners();
  }

  changeBodyType1(int? i) {
    bodyType1 = i ?? 1;
    switch (i) {
      case 1:
        detailBodyName = "營業收入";
        sqlTitleName = "nnor";
        break;
      case 2:
        detailBodyName = "營業毛利";
        sqlTitleName = "nop";
        break;
      case 3:
        detailBodyName = "營業利益";
        sqlTitleName = "bi";
        break;
      case 4:
        detailBodyName = "稅後純益";
        sqlTitleName = "pat";
        break;
      case 5:
        detailBodyName = "每股盈餘";
        sqlTitleName = "eps";
        break;
    }
    print("type===$titleType   name ==$sqlTitleName ");
    notifyListeners();
  }

  changeBodyType2(int? i) {
    bodyType2 = i ?? 1;
    switch (i) {
      case 1:
        detailBodyName = "流動比率";
        sqlTitleName = "cr";
        break;
      case 2:
        detailBodyName = "速動比率";
        sqlTitleName = "qr";
        break;
      case 3:
        detailBodyName = "利息保障倍數";
        sqlTitleName = "dscr";
        break;
    }
    notifyListeners();
  }

  changeBodyType3(int? i) {
    bodyType3 = i ?? 1;
    switch (i) {
      case 1:
        detailBodyName = "毛利率";
        sqlTitleName = "gpm";
        break;
      case 2:
        detailBodyName = "營業利益率";
        sqlTitleName = "om";
        break;
      case 3:
        detailBodyName = "稅後純益率";
        sqlTitleName = "pm";
        break;
      case 4:
        detailBodyName = "資產報酬率";
        sqlTitleName = "roa";
        break;
      case 5:
        detailBodyName = "權益報酬率";
        sqlTitleName = "roe";
        break;
    }
    notifyListeners();
  }

  Future<List<String>> selectCompny(String id) async {
    if (id == "") {
      print("null");
      return [];
    } else {
      List<Map<String, Object?>> stockList = [];
      List<String> result = [];
      stockList =
          await db.select("select * from home2 where  ts LIKE  '%$id%'");

      for (Map<String, Object?> r in stockList) {
        result.add("${r["ts"]} ${r["name"]}");
      }
      return result;
    }
  }

  String getTs(String text) {
    List l = text.split(" ");
    if (l.length > 1) {
      return l[0];
    } else {
      return "";
    }
  }

  selectCompareResult() async {
    print("name==$sqlTableName  sqlTitleName $sqlTitleName ");
    String sql1 = "select * from $sqlTableName where ";
    String whereName1 = "", whereName2 = "", whereName3 = "";
    String sqlWhere = "";
    List<Map<String, Object?>> stockList = [];
    dbResult1 = [];
    dbResult2 = [];
    dbResult3 = [];
    saveIndex = 1;
    maxY = .0;
    minY = .0;
    String saveTs = "";
    //   List<String> result = [];
    if (textController1.text != "") {
      String l = getTs(textController1.text);
      if (l != "") whereName1 = "or ts=$l ";
    }
    if (textController2.text != "") {
      String l = getTs(textController2.text);
      if (l != "") whereName2 = "or ts=$l ";
    }
    if (textController3.text != "") {
      String l = getTs(textController3.text);
      if (l != "") whereName3 = "or ts=$l ";
    }
    sqlWhere = whereName1 + whereName2 + whereName3;
    if (sqlWhere.startsWith("or")) {
      sqlWhere = sqlWhere.substring(2, sqlWhere.length);
    }
    if (sqlWhere != "") {
      print("sql code===${"$sql1 $sqlWhere order  by ts , year desc "}");
      stockList = await db.select("$sql1 $sqlWhere order by ts , year desc ");
    }
    print("stock list len ==${stockList.length}");
    //sqlit
    for (Map<String, Object?> m in stockList) {
      double v = double.parse(m[sqlTitleName].toString());
      if (maxY < v) {
        maxY = v;
      }
      if (minY > v) {
        minY = v;
      }

      if (saveTs == "") {
        dbResult1.add(m);

        saveTs = m["ts"].toString();
      } else if (saveTs != m["ts"].toString()) {
        saveIndex += 1;
        if (saveIndex == 2) {
          dbResult2.add(m);
          saveTs = m["ts"].toString();
        } else if (saveIndex == 3) {
          dbResult3.add(m);
          saveTs = m["ts"].toString();
        }
      } else if (saveTs == m["ts"].toString()) {
        if (saveIndex == 1) {
          dbResult1.add(m);
        } else if (saveIndex == 2) {
          dbResult2.add(m);
        } else {
          dbResult3.add(m);
        }
        saveTs = m["ts"].toString();
      }
    }
    print("result 1 ==$dbResult1");
    print(
        "save index ===$saveIndex  maxX ==$maxY  dbResult1 len ==${dbResult1.length}  dbResult2 len ===${dbResult2.length}  dbResult3 len ===${dbResult3.length}");

    // if (id == "") {
    //   print("null");
    //   return [];
    // } else {
    //   List<Map<String, Object?>> stockList = [];
    //   List<String> result = [];
    //   stockList =
    //       await db.select("select * from home2 where  ts LIKE  '%$id%'");

    //   for (Map<String, Object?> r in stockList) {
    //     result.add("${r["ts"]} ${r["name"]}");
    //   }
    //   return result;
    // }
  }
}
