import 'package:auto_route/auto_route.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/preferences/preferences_repository_impl.dart';
import '../../data/model/user.dart';
import '../routes/app_route.gr.dart';
import 'home_view_model.dart';

//首頁ui
class HomePage extends HookConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  Widget btn({
    required IconData iconData,
    required String title,
    required VoidCallback onTap,
    required bool isChangeColor,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20.sp),
        ),
        Container(
          margin: EdgeInsets.only(top: 1.h),
          width: 20.w,
          height: 20.w,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: isChangeColor
                    ? Color(0xff4585B5)
                        .withOpacity(User.instance.isAccountLogin ? 1 : 0.5)
                    : Color(0xff4585B5),
                side: BorderSide(
                  width: 1.0,
                  color: isChangeColor
                      ? Color(0xff4585B5)
                          .withOpacity(User.instance.isAccountLogin ? 1 : 0.5)
                      : Color(0xff4585B5),
                  style: BorderStyle.solid,
                ),
                padding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1000))),
              ),
              onPressed: onTap,
              child: Icon(
                iconData,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(homeViewModelProvider);
    final l10n = useL10n();
    final perferences = PreferencesRepositoryImpl();
    nextUntilPage(BuildContext context, PageRouteInfo pageRoute) {
      AutoRouter.of(context)
          .pushAndPopUntil(pageRoute, predicate: (_) => false);
    }

    nextPage(BuildContext context, PageRouteInfo pageRoute) {
      AutoRouter.of(context).push(pageRoute);
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btn(
                    iconData: Icons.attach_money_outlined,
                    title: "財務狀況",
                    onTap: () {
                      nextPage(context, SearchStockPag(pageRoute: "finance"));
                    },
                    isChangeColor: true),
                btn(
                    iconData: Icons.trending_up_rounded,
                    title: "熱門排行",
                    onTap: () {
                      nextPage(context, const HotRoute());
                    },
                    isChangeColor: false),
                btn(
                    iconData: Icons.search,
                    title: "自選股",
                    onTap: () {
                      nextPage(context, const SaveSelectRoute());
                    },
                    isChangeColor: true),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btn(
                    iconData: Icons.add_chart_rounded,
                    title: "上市股票",
                    onTap: () {
                      nextPage(context, SearchStockPag(pageRoute: "stock"));
                    },
                    isChangeColor: false),
                btn(
                    iconData: Icons.all_inclusive_sharp,
                    title: "多股比較",
                    onTap: () {
                      nextPage(context, const CompareRoute());
                    },
                    isChangeColor: true),
                btn(
                    iconData: User.instance.isAccountLogin
                        ? Icons.logout_outlined
                        : Icons.login_outlined,
                    title: User.instance.isAccountLogin ? "會員登出" : "會員登入",
                    onTap: () {
                      perferences.removeAccount();
                      nextUntilPage(context, const LoginRoute());
                    },
                    isChangeColor: false),
              ],
            )
          ],
        ),
      ),
    );
  }
}
