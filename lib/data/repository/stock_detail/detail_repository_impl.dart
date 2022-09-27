import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'detail_repository.dart';

final detailRepositoryProvider =
    Provider((ref) => DetailRepositoryImpl(ref.read));

class DetailRepositoryImpl implements DetailRepository {
  DetailRepositoryImpl(this._reader);

  final Reader _reader;

  @override
  Future<String> getStackData() {
    return rootBundle.loadString('assets/data/chatData.json');
  }
//remote
}
