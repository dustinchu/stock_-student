import 'package:auto_route/auto_route.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/widget/field.dart';
import '../routes/route_path.dart';
import 'components/check_box.dart';
import 'login_view_model.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(loginViewModelProvider).isAccountData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(loginViewModelProvider);

    // final viewModel = ref.watch(loginViewModelProvider.notifier);
    final l10n = useL10n();
    return Scaffold(
      // backgroundColor: secondaryColor,
      body: Center(
        child: state.accountLoadingStatus == AccountLoadingStatus.loding
            ? const CircularProgressIndicator()
            : ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image(image: AssetImage("assets/img/logo.jpeg")),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "歡迎",
                            style: theme.textTheme.h50,
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 400,
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Field(
                                      onChanged: (text) {
                                        // state.emailValidation(text)
                                      },
                                      controller: state.usernameController,
                                      isPassword: false,
                                      hintText: "帳號",
                                      theme: theme,
                                      isShowEye: false,
                                    ),
                                    // Text(
                                    //   state.email ? "" : "信箱格式不正確",
                                    //   style: theme.textTheme.h20
                                    //       .copyWith(color: theme.appColors.error),
                                    // ),
                                    Field(
                                      onChanged: (text) {},
                                      controller: state.passwordController,
                                      isPassword: true,
                                      hintText: "密碼",
                                      isShowEye: true,
                                      theme: theme,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CkBox(
                                          value: state.checkBoxStatus,
                                          changed: (bool) =>
                                              state.changeBoxStatus(bool!),
                                          text: "保持登入",
                                        ),
                                        // TextButton(
                                        //     onPressed: () => AutoRouter.of(context)
                                        //         .pushNamed(RoutePath.register),
                                        //     child: Text(
                                        //       "忘記密碼",
                                        //       style: theme.textTheme.h20.copyWith(
                                        //           color:
                                        //               theme.appColors.primaryVariant),
                                        //     ))
                                      ],
                                    ),
                                    state.loginStatus == LoginStatus.loding
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Column(
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    state.login(context);
                                                  },
                                                  child: const Text(
                                                    '登入',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: OutlinedButton(
                                                  onPressed: () =>
                                                      AutoRouter.of(context)
                                                          .pushNamed(RoutePath
                                                              .register)
                                                          .then((value) =>
                                                              state.clean(value
                                                                  .toString())),
                                                  child: const Text('申辦會員'),
                                                ),
                                              ),
                                              Center(
                                                child: TextButton(
                                                    onPressed: () =>
                                                        state.nextHome(context),
                                                    child: Text(
                                                      "只想體驗不想註冊",
                                                      style: theme.textTheme.h20
                                                          .copyWith(
                                                              color: theme
                                                                  .appColors
                                                                  .primaryVariant),
                                                    )),
                                              )
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
