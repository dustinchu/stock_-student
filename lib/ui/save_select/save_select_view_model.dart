import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/util/logger.dart';

final saveSelectViewModelProvider = ChangeNotifierProvider((ref) {
  return SaveSelectViewModel(ref.read);
});

enum SaveSelectStatus {
  success,
  fail,
  start,
  loding,
}

class SaveSelectViewModel extends ChangeNotifier with LoggerMixin {
  SaveSelectViewModel(this._reader);

  final Reader _reader;
  // late final LoginRepository _repository = _reader(loginRepositoryProvider);

  //SaveSelect status
  SaveSelectStatus saveSelectStatus = SaveSelectStatus.start;

  Future<void> SaveSelect() async {}
}
