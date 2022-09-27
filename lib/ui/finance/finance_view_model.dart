import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/service/db.dart';
import '../../common/util/logger.dart';
import '../stock_detail/stock_detail_view_model.dart';

final financeViewModelProvider = ChangeNotifierProvider((ref) {
  final financeViewModelProvider = FinanceViewModel(ref.read);
  return financeViewModelProvider;
});

enum FinanceStatus {
  success,
  fail,
  start,
  loding,
}

class FinanceViewModel extends ChangeNotifier with LoggerMixin {
  FinanceViewModel(this.reader);

  final Reader reader;

  late final StockDetailViewModel stockState =
      reader(stockDetailViewModelProvider);
  // late final LoginRepository _repository = _reader(loginRepositoryProvider);

  //finance status
  FinanceStatus financeStatus = FinanceStatus.start;
  List<Map<String, Object?>> stockList = [];
  DB db = DB();
  TextEditingController textEditingController = TextEditingController();
  init(String ts) async {
    stockList =
        await db.select("SELECT * FROM finance where id=2021 and ts=$ts; ");
    notifyListeners();
  }

  selectYear(String ts, String year) async {
    // stockList = await db.select(
    //     "select detail.* , detail2.totalAssets ,detail2.totalEquity,detail2.netProfit  from detail, detail2  where  detail.ts =detail2.ts and  detail.year =detail2.year and detail.ts='$ts'  and detail.year ='$year'");
    stockList =
        await db.select("SELECT * FROM finance where id=$year and ts=$ts; ");
    notifyListeners();
    //     financeStatus = FinanceStatus.success;
    //     notifyListeners();
    // textEditingController.addListener(() async {
    //   if (textEditingController.text == "") {
    //     print("------${textEditingController.text}");
    //     stockList = await db.select("select * from detail");
    //     financeStatus = FinanceStatus.success;
    //     notifyListeners();
    //   } else {
    //     stockList = await db.select(
    //         "select * from detail where  ts LIKE  '%${textEditingController.text}%'");
    //     financeStatus = FinanceStatus.success;
    //     notifyListeners();
    //   }
    // });
  }
}
