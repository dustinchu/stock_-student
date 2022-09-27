import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/util/logger.dart';
import '../../data/repository/register/register_repository.dart';
import '../../data/repository/register/register_repository_impl.dart';

final registerViewModelProvider = ChangeNotifierProvider((ref) {
  final registerViewModelProvider = RegisterViewModel(ref.read);
  registerViewModelProvider.init();
  return registerViewModelProvider;
});

enum RegisterStatus {
  success,
  fail,
  start,
  loding,
}

class RegisterViewModel extends ChangeNotifier with LoggerMixin {
  RegisterViewModel(this._reader);

  final Reader _reader;

  late final RegisterRepository _repository =
      _reader(registerRepositoryProvider);

  //control
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //Register status
  RegisterStatus registerStatus = RegisterStatus.start;
  //password validation
  bool passwordValidation = false;
  bool emailValidation = false;

  String username = "";
  String password = "";
  String checkPassword = "";
  String email = "";

  init() {
    usernameController.text = "";
    passwordController.text = "";
    checkPasswordController.text = "";
    emailController.text = "";
    usernameController.addListener(usernaneListener);
    passwordController.addListener(passwordListener);
    checkPasswordController.addListener(checkPasswordListener);
    emailController.addListener(emailListener);
  }

  usernaneListener() => username = usernameController.text;
  passwordListener() => password = passwordController.text;
  checkPasswordListener() {
    checkPassword = checkPasswordController.text;
    if (checkPassword != password) {
      passwordValidation = true;
    } else {
      passwordValidation = false;
    }
    notifyListeners();
  }

  emailListener() {
    email = emailController.text;
    emailValidation = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    notifyListeners();
  }

  nameChanged(String _text) {}
  passwordChanged(String _text) {}
  checkPasswordChanged(String _text) {}
  emanilChanged(String _text) {}

  Future<List<String>> register() async {
    if (password != checkPassword) {
      return ["fail", "密碼不一致"];
    } else if (!emailValidation) {
      return ["fail", "信箱格式不正確"];
    } else if (username.isEmpty ||
        password.isEmpty ||
        checkPassword.isEmpty ||
        email.isEmpty) {
      return ["fail", "資料不可為空"];
    }

    registerStatus = RegisterStatus.loding;
    notifyListeners();
    List<String> httpStatus = [];
    await _repository
        .registerPost(username, password, email)
        .then((value) async {
      if (value) {
        registerStatus = RegisterStatus.success;
        httpStatus = ["success", ""];
      } else {
        print("??");
        registerStatus = RegisterStatus.fail;
        httpStatus = ["fail", "註冊失敗"];
      }
    }).whenComplete(() {
      notifyListeners();
    });
    return httpStatus;
  }
}
