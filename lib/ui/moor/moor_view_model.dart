import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/util/logger.dart';
import '../routes/app_route.gr.dart';

final moorViewModelProvider = ChangeNotifierProvider((ref) {
  return MoorViewModel(ref.read);
});

enum MoorStatus {
  success,
  fail,
  start,
  loding,
}

class MoorViewModel extends ChangeNotifier with LoggerMixin {
  MoorViewModel(this._reader);

  final Reader _reader;
  // late final LoginRepository _repository = _reader(loginRepositoryProvider);

  //moor status
  MoorStatus moorStatus = MoorStatus.start;

  nextHome(BuildContext context) {
    AutoRouter.of(context)
        .pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
  }
}
