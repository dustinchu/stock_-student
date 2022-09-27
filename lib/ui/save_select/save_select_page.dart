import 'package:auto_route/auto_route.dart';
import 'package:flapp/common/widget/dialog.dart';
import 'package:flapp/data/model/user.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../hot/components/list_card.dart';
import '../hot/hot_view_model.dart';
import '../routes/app_route.gr.dart';

class SaveSelectPage extends StatefulHookConsumerWidget {
  const SaveSelectPage({Key? key}) : super(key: key);

  @override
  SaveSelectPageState createState() => SaveSelectPageState();
}

class SaveSelectPageState extends ConsumerState<SaveSelectPage> {
  nextUntilPage(BuildContext context, PageRouteInfo pageRoute) {
    AutoRouter.of(context).pushAndPopUntil(pageRoute, predicate: (_) => false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!User.instance.isAccountLogin)
        dialog(context);
      else {
        ref.read(hotViewModelProvider).allData(
            "select * from home  where  id =1640793600  and  sava_status=1",
            "stock");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(hotViewModelProvider);
    final l10n = useL10n();

    return Scaffold(
      appBar: AppBar(
        title: Text("自選"),
        centerTitle: true,
      ),
      body: User.instance.isAccountLogin
          ? Scaffold(
              body: state.stockList.length == 0
                  ? Container(
                      child: Center(child: Text("目前沒有自選的組合")),
                    )
                  : ListCard(
                      pageRoute: "stock",
                      isSearch: false,
                      tabIndex: 4,
                    ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "登入帳戶跨裝置同步自選股，並自訂自己的投資組合。",
                    style: theme.textTheme.h20,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextButton(
                      onPressed: () =>
                          nextUntilPage(context, const LoginRoute()),

                      // AutoRouter.of(context).replaceNamed(RoutePath.login),
                      child: Text(
                        "登入",
                        style: theme.textTheme.h20
                            .copyWith(color: theme.appColors.primaryVariant),
                      ))
                ],
              ),
            ),
    );
  }
}
