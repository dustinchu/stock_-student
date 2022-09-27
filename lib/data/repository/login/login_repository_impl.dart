import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/net/http_serviceImpl.dart';
import '../../model/result/result.dart';
import 'login_repository.dart';

final loginRepositoryProvider =
    Provider((ref) => LoginRepositoryImpl(ref.read));

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._reader);

  final Reader _reader;
  final _httpService = new HttpServiceImpl();
//remote
  @override
  Future<bool> loginPost(String username, String password) async {
    bool loginStatus = false;
    return Result.guardFuture(
            () async => await _httpService.LoginPost(username, password))
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
