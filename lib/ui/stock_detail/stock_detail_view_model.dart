import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:k_chart/entity/index.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../common/service/db.dart';
import '../../common/util/logger.dart';
import '../../data/repository/stock_detail/detail_repository.dart';
import '../../data/repository/stock_detail/detail_repository_impl.dart';

final stockDetailViewModelProvider = ChangeNotifierProvider((ref) {
  final stockDetailViewModelProvider = StockDetailViewModel(ref.read);
  // stockDetailViewModelProvider.solveChatData();
  return stockDetailViewModelProvider;
});
enum StockDetailStatus {
  success,
  fail,
  start,
  loding,
}

class StockDetailViewModel extends ChangeNotifier with LoggerMixin {
  StockDetailViewModel(this._reader);

  final Reader _reader;
  late final DetailRepository _repository = _reader(detailRepositoryProvider);
  //stock_detail_ status
  StockDetailStatus stockDetailStatus = StockDetailStatus.start;

  List<KLineEntity>? datas;
  List<Map<String, Object?>> stockList = [];
  DB db = DB();
  int kLineType = 0;
  // void solveChatData() async {
  //   if (stockDetailStatus != StockDetailStatus.start) {
  //     stockDetailStatus = StockDetailStatus.start;
  //     notifyListeners();
  //   }

  //   await _repository.getStackData().then((result) {
  //     final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
  //     final list = parseJson['data'] as List<dynamic>;
  //     datas = list
  //         .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
  //         .toList()
  //         .reversed
  //         .toList()
  //         .cast<KLineEntity>();
  //     DataUtil.calculate(datas!);
  //   });
  //   stockDetailStatus = StockDetailStatus.success;
  //   notifyListeners();
  // }
  changeKLineType(int type) {
    kLineType = type;
    notifyListeners();
  }

  selectDetailData(String sqlCode) async {
    stockDetailStatus = StockDetailStatus.loding;
    notifyListeners();
    DateTime dt = DateTime.now();
    stockList = await db.select(sqlCode);

    DateTime d2 = DateTime.now();

    var sec = d2.difference(dt).inSeconds;
    log("select sec ==$sec");
    datas = stockList
        .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();
    DataUtil.calculate(datas!);
    stockDetailStatus = StockDetailStatus.success;
    notifyListeners();
  }
}
