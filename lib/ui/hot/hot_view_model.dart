import 'package:flapp/data/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../common/service/db.dart';
import '../../common/util/logger.dart';
import '../../common/widget/dialog.dart';
import '../stock_detail/stock_detail_view_model.dart';

final hotViewModelProvider = ChangeNotifierProvider((ref) {
  final hotViewModelProvider = HotViewModel(ref.read);
  hotViewModelProvider.init();
  return hotViewModelProvider;
});

enum HotStatus {
  success,
  fail,
  start,
  loding,
}

class HotViewModel extends ChangeNotifier with LoggerMixin {
  HotViewModel(this.reader);

  final Reader reader;

  late final StockDetailViewModel stockState =
      reader(stockDetailViewModelProvider);
  // late final LoginRepository _repository = _reader(loginRepositoryProvider);

  //Hot status
  HotStatus hotStatus = HotStatus.start;
  List<Map<String, Object?>> stockList = [];
  DB db = DB();
  TextEditingController textEditingController = TextEditingController();
  String pageRoute = "";
  String hotDate = "";
  int tabIndex = 1;
  String saveSqlCode = "";
  init() async {
    textEditingController.addListener(() async {
      if (textEditingController.text == "") {
        if (pageRoute == "" || pageRoute == "stock") {
          saveSqlCode = "select * from home  where id =1640793600 ";
          stockList = await db.select(saveSqlCode);
          hotStatus = HotStatus.success;
          print("saveSqlcode ==$saveSqlCode");
        } else {
          stockList = [];
          hotStatus = HotStatus.success;
        }

        notifyListeners();
      } else {
        saveSqlCode =
            "select * from home where   id =1640793600  and  ts LIKE  '%${textEditingController.text}%'  ";
        stockList = await db.select(saveSqlCode);
        hotStatus = HotStatus.success;
        print("saveSqlcode ==$saveSqlCode");
        notifyListeners();
      }
    });
    //暫時先用detail
    // stockList = await db.select("select * from detail");
    // hotStatus = HotStatus.success;
    // notifyListeners();

    // db.createTeble(
    //     "'CREATE TABLE likeStock (id INTEGER PRIMARY KEY AUTOINCREMENT,ts INTEGER, name TEXT)'");
  }

  testDate() {
    print("hotData==$hotDate");
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(hotDate) * 1000);
    var d12 = DateFormat('yyyy-MM-dd').format(date);
    print(d12);

    DateTime tempDate = DateFormat('yyyy-MM-dd').parse(d12);
    print((tempDate.microsecondsSinceEpoch / 1000000).toInt());
  }

  selectDate(DateTime dt) async {
    int d = (dt.microsecondsSinceEpoch / 1000000).toInt();
    textEditingController.text = "";
    String sqlCode = "";
    print("tabIndex==$tabIndex");
    switch (tabIndex) {
      case 1:
        sqlCode =
            "select * from home  where id=$d   order by amount desc limit 20";
        break;
      case 2:
        sqlCode = "select * from home where id =$d  order by vo desc  limit 20";
        break;
      case 3:
        sqlCode = "select * from home   where id =$d   order by vo   limit 20";
        break;
    }
    stockList = await db.select(sqlCode);

    var date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(stockList[0]["id"].toString()) * 1000);
    var hotDt = DateFormat('yyyy-MM-dd').format(date);
    hotDate = hotDt;
    hotStatus = HotStatus.success;
    notifyListeners();
  }

  clean(String pageRouteName) {
    pageRoute = pageRouteName;
    textEditingController.text = "";
    stockList = [];
    notifyListeners();
  }

  hotData(String sqlCode, int i) async {
    tabIndex = i;
    textEditingController.text = "";

    stockList = await db.select(sqlCode);

    var date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(stockList[0]["id"].toString()) * 1000);
    var dt = DateFormat('yyyy-MM-dd').format(date);
    hotDate = dt;
    hotStatus = HotStatus.success;
    notifyListeners();
  }

  allData(String sqlCode, String pageRouteName) async {
    pageRoute = pageRouteName;
    textEditingController.text = "";
    stockList = await db.select(sqlCode);
    hotStatus = HotStatus.success;
    notifyListeners();
  }

  insertLikeStock(int ts, String name) {
    db.insertLikeValue(ts, name);
  }

  deleteLikeStock(int ts) {
    db.deleteLikeValue(ts);
  }

  savaStock(BuildContext context, int ts, String status, int tabIndex) async {
    if (User.instance.isAccountLogin) {
      await db.like(ts, status);
      String sqlCode = "";

      switch (tabIndex) {
        case 0:
          print("sqlcode==$saveSqlCode");
          if (saveSqlCode == "") {
            sqlCode = "select * from home   where id =1640793600 ";
          } else {
            sqlCode = saveSqlCode;
          }

          break;
        case 1:
          DateTime tempDate = DateFormat('yyyy-MM-dd').parse(hotDate);
          int dt = (tempDate.microsecondsSinceEpoch / 1000000).toInt();
          sqlCode =
              "select * from home where id =$dt order by amount desc limit 20";
          break;
        case 2:
          DateTime tempDate = DateFormat('yyyy-MM-dd').parse(hotDate);
          int dt = (tempDate.microsecondsSinceEpoch / 1000000).toInt();
          sqlCode =
              "select * from home where id =$dt  order by vo desc  limit 20";
          break;
        case 3:
          DateTime tempDate = DateFormat('yyyy-MM-dd').parse(hotDate);
          int dt = (tempDate.microsecondsSinceEpoch / 1000000).toInt();
          sqlCode =
              "select * from home   where id =$dt   order by vo   limit 20";
          break;
        case 4:
          sqlCode =
              "select * from home   where  id =1640793600  and  sava_status=1 ";
          break;
      }
      print("select code ==$sqlCode");
      stockList = await db.select(sqlCode);
      // for (var a in stockList) {
      //   print(a.toString());
      // }
      notifyListeners();
    } else {
      dialog(context);
    }
  }

  nextDetailSelect(String ts) {
    stockState.selectDetailData(ts);
  }
}
