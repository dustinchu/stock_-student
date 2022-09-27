import 'package:auto_route/auto_route.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/preferences/preferences_repository_impl.dart';
import '../../data/model/user.dart';
import '../routes/app_route.gr.dart';
import 'moor_view_model.dart';

class MoorPage extends HookConsumerWidget {
  const MoorPage({Key? key}) : super(key: key);
  nextUntilPage(BuildContext context, PageRouteInfo pageRoute) {
    AutoRouter.of(context).pushAndPopUntil(pageRoute, predicate: (_) => false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(moorViewModelProvider);
    final l10n = useL10n();
    final _perferences = PreferencesRepositoryImpl();
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          _perferences.removeAccount();
          // state.nextHome(context);
          nextUntilPage(context, const LoginRoute());
        },
        child: Text(
          User.instance.isAccountLogin ? "登出" : "回到登入頁面",
          style: theme.textTheme.h30,
        ),
      )),
    );
  }
}
