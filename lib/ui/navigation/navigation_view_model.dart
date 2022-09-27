import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/util/logger.dart';

final navigationViewModelProvider = ChangeNotifierProvider((ref) {
  return NavigationViewModel(ref.read);
});

class NavigationViewModel extends ChangeNotifier with LoggerMixin {
  NavigationViewModel(this._reader);

  final Reader _reader;

  int currentIndex = 1;

  bool passwordValidation = false;

  setCurrenIndex(int _index) {
    currentIndex = _index;
    notifyListeners();
  }

  init() {
    currentIndex = 1;
    notifyListeners();
  }

  Future<void> navigation() async {}
}
