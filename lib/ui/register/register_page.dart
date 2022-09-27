import 'package:auto_route/auto_route.dart';
import 'package:flapp/common/widget/dialog.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/row_widget.dart';
import 'register_view_model.dart';

class RegisterPage extends StatefulHookConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ConsumerState<RegisterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(registerViewModelProvider).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(registerViewModelProvider);
    final l10n = useL10n();
    Widget appbar() {
      return Container(
        height: 7.h,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.transparent,
            ),
            Center(
              child: Text(
                "註冊",
                style: theme.textTheme.h40,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () => AutoRouter.of(context).pop(""),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(),
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            appbar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 10.w),
                child: ListView(
                  children: [
                    RowWidget(
                      title: "帳號",
                      controller: state.usernameController,
                      onChange: state.nameChanged,
                      hintText: "帳號",
                      isPassword: false,
                      isShowEye: false,
                    ),
                    RowWidget(
                      title: "密碼",
                      controller: state.passwordController,
                      onChange: state.passwordChanged,
                      hintText: "密碼",
                      isPassword: true,
                      isShowEye: true,
                    ),
                    RowWidget(
                      title: "再次確認密碼",
                      controller: state.checkPasswordController,
                      onChange: state.checkPasswordChanged,
                      hintText: "再次確認密碼",
                      isPassword: true,
                      isShowEye: true,
                    ),
                    state.passwordValidation
                        ? Text(
                            "密碼不一致",
                            style: theme.textTheme.h20
                                .copyWith(color: theme.appColors.error),
                          )
                        : Container(),
                    RowWidget(
                      title: "Email",
                      controller: state.emailController,
                      onChange: state.emanilChanged,
                      hintText: "Email",
                      isPassword: false,
                      isShowEye: false,
                    ),
                    !state.emailValidation
                        ? Text(
                            "請輸入正確的信箱格式",
                            style: theme.textTheme.h20
                                .copyWith(color: theme.appColors.error),
                          )
                        : Container(),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: state.registerStatus != RegisterStatus.loding
                          ? OutlinedButton(
                              onPressed: () async {
                                List<String> registerStatus =
                                    await state.register();
                                if (registerStatus[0] == "fail") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return msgDialog(
                                            context, "錯誤", registerStatus[1]);
                                      });
                                } else {
                                  showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return msgDialog(
                                                context, "成功", "註冊成功請重新登入");
                                          })
                                      .then((value) => AutoRouter.of(context)
                                          .pop(state.usernameController.text));
                                }
                                debugPrint('Received click');
                              },
                              child: const Text('註冊'),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
