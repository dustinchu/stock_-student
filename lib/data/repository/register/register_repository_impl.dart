import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/net/http_serviceImpl.dart';
import '../../model/result/result.dart';
import 'register_repository.dart';

final registerRepositoryProvider =
    Provider((ref) => RegisterRepositoryImpl(ref.read));

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._reader);

  final Reader _reader;
  final _httpService = new HttpServiceImpl();

//remote
  @override
  Future<bool> registerPost(
      String username, String password, String email) async {
    return Result.guardFuture(() async =>
            await _httpService.RegisterPost(username, password, email))
        .then((value) async => value.when(
              success: (data) {
                return true;
              },
              failure: (error) {
                return false;
              },
            ));
  }
}
