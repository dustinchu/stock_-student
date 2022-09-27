// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../common/util/logger.dart';

// final homeViewModelProvider = ChangeNotifierProvider((ref) {
//   return HomeViewModel(ref.read);
// });

// enum HomeStatus {
//   success,
//   fail,
//   start,
//   loding,
// }

// class HomeViewModel extends ChangeNotifier with LoggerMixin {
//   HomeViewModel(this._reader);

//   final Reader _reader;
//   // late final LoginRepository _repository = _reader(loginRepositoryProvider);

//   //home status
//   HomeStatus homeStatus = HomeStatus.start;
// }
