import 'package:auto_route/auto_route.dart';
import 'package:flapp/common/widget/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/preferences/preferences_repository_impl.dart';
import '../../common/service/db.dart';
import '../../common/util/logger.dart';
import '../../data/model/user.dart';
import '../../data/repository/login/login_repository.dart';
import '../../data/repository/login/login_repository_impl.dart';
import '../routes/app_route.gr.dart';

final loginViewModelProvider = ChangeNotifierProvider((ref) {
  final loginViewModelProvider = LoginViewModel(ref.read);
  loginViewModelProvider.init();
  return loginViewModelProvider;
});

enum LoginStatus {
  success,
  fail,
  start,
  loding,
}

enum AccountLoadingStatus {
  success,
  loding,
}

class LoginViewModel extends ChangeNotifier with LoggerMixin {
  LoginViewModel(this._reader);

  final Reader _reader;
  final _perferences = PreferencesRepositoryImpl();
  late final LoginRepository _repository = _reader(loginRepositoryProvider);
  //control
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //login status
  LoginStatus loginStatus = LoginStatus.start;
  AccountLoadingStatus accountLoadingStatus = AccountLoadingStatus.loding;
  //checkbox
  bool checkBoxStatus = false;
  //eamil validation
  // bool email = true;
  DB db = DB();
  init() async {
    await db.copy();
  }

  // emailValidation(String _text) {
  //   email = _text.isEmail();
  //   notifyListeners();
  // }

  isAccountData(BuildContext context) async {
    if (accountLoadingStatus != AccountLoadingStatus.loding) {
      accountLoadingStatus = AccountLoadingStatus.loding;
      notifyListeners();
    }
    bool status = await _perferences.getAccount() == "" ? false : true;
    User.instance.isAccountLogin = status;

    if (status) {
      nextHome(context);
    } else {
      accountLoadingStatus = AccountLoadingStatus.success;
      notifyListeners();
    }
  }

  changeBoxStatus(bool _value) {
    checkBoxStatus = _value;
    notifyListeners();
  }

  clean(String username) {
    usernameController.text = username;
    passwordController.text = "";
    checkBoxStatus = false;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    loginStatus = LoginStatus.loding;
    notifyListeners();
    return _repository
        .loginPost(usernameController.text, passwordController.text)
        .then((value) async {
      if (value) {
        loginStatus = LoginStatus.success;
        if (checkBoxStatus) {
          _perferences.saveAccount(usernameController.text);
        }
        User.instance.isAccountLogin = true;
        nextHome(context);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return msgDialog(context, "錯誤", "帳號密碼錯誤");
            });

        loginStatus = LoginStatus.fail;
      }
    }).whenComplete(() {
      notifyListeners();
    });
  }

  nextHome(BuildContext context) {
    AutoRouter.of(context)
        .pushAndPopUntil(HomeRoute(), predicate: (_) => false);
  }
}
