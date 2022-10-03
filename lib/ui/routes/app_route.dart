import 'package:auto_route/auto_route.dart';
import 'package:flapp/ui/home/home_page.dart';
import 'package:flapp/ui/hot/hot_page.dart';
import 'package:flapp/ui/login/login_page.dart';
import 'package:flapp/ui/routes/route_path.dart';

import '../compare/compare_detail_page.dart';
import '../compare/compare_page.dart';
import '../finance/finance_page.dart';
import '../finance/search_stock_page.dart';
import '../moor/moor_page.dart';
import '../register/register_page.dart';
import '../save_select/save_select_page.dart';
import '../stock_detail/stock_detail_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: RoutePath.login,
      page: LoginPage,
      initial: true,
    ),
    AutoRoute(
      path: RoutePath.register,
      page: RegisterPage,
    ),
    AutoRoute(
      path: RoutePath.hot,
      page: HotPage,
    ),
    AutoRoute(
      path: RoutePath.stockDetailPage,
      page: StockDetailPage,
    ),
    AutoRoute(
      path: RoutePath.home,
      page: HomePage,
    ),
    AutoRoute(
      path: RoutePath.saveSelectPage,
      page: SaveSelectPage,
    ),
    AutoRoute(
      path: RoutePath.moor,
      page: MoorPage,
    ),
    AutoRoute(
      path: RoutePath.financeSearchPage,
      page: SearchStockPag,
    ),
    AutoRoute(
      path: RoutePath.financePage,
      page: FinancePage,
    ),
    AutoRoute(
      path: RoutePath.comparePage,
      page: ComparePage,
    ),
    AutoRoute(
      path: RoutePath.chartPage,
      page: CompareDetailPage,
    ),
  ],
)
class $AppRouter {}
