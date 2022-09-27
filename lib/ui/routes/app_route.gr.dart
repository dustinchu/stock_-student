// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flapp/ui/finance/finance_page.dart' as _i10;
import 'package:flapp/ui/finance/search_stock_page.dart' as _i9;
import 'package:flapp/ui/home/home_page.dart' as _i6;
import 'package:flapp/ui/hot/hot_page.dart' as _i4;
import 'package:flapp/ui/login/login_page.dart' as _i1;
import 'package:flapp/ui/moor/moor_page.dart' as _i8;
import 'package:flapp/ui/register/register_page.dart' as _i3;
import 'package:flapp/ui/save_select/save_select_page.dart' as _i7;
import 'package:flapp/ui/stock_detail/stock_detail_page.dart' as _i5;
import 'package:flapp/ui/xxx/xxx_page.dart' as _i2;
import 'package:flutter/material.dart' as _i12;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    XXXRoute.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.XXXPage());
    },
    RegisterRoute.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.RegisterPage());
    },
    HotRoute.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.HotPage());
    },
    StockDetailRoute.name: (routeData) {
      final args = routeData.argsAs<StockDetailRouteArgs>();
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.StockDetailPage(
              key: args.key,
              id: args.id,
              name: args.name,
              close: args.close,
              vo: args.vo,
              vo2: args.vo2,
              amount: args.amount,
              date: args.date));
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: _i6.HomePage(key: args.key));
    },
    SaveSelectRoute.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.SaveSelectPage());
    },
    MoorRoute.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i8.MoorPage());
    },
    SearchStockPag.name: (routeData) {
      final args = routeData.argsAs<SearchStockPagArgs>();
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i9.SearchStockPag(key: args.key, pageRoute: args.pageRoute));
    },
    FinanceRoute.name: (routeData) {
      final args = routeData.argsAs<FinanceRouteArgs>();
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i10.FinancePage(ts: args.ts, key: args.key));
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig('/#redirect',
            path: '/', redirectTo: '/login', fullMatch: true),
        _i11.RouteConfig(LoginRoute.name, path: '/login'),
        _i11.RouteConfig(XXXRoute.name, path: '/xxx'),
        _i11.RouteConfig(RegisterRoute.name, path: '/register'),
        _i11.RouteConfig(HotRoute.name, path: '/hot'),
        _i11.RouteConfig(StockDetailRoute.name, path: '/stockDetailPage'),
        _i11.RouteConfig(HomeRoute.name, path: '/home'),
        _i11.RouteConfig(SaveSelectRoute.name, path: '/saveSelectPage'),
        _i11.RouteConfig(MoorRoute.name, path: '/moor'),
        _i11.RouteConfig(SearchStockPag.name, path: '/financeSearchPage'),
        _i11.RouteConfig(FinanceRoute.name, path: '/financePage')
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.XXXPage]
class XXXRoute extends _i11.PageRouteInfo<void> {
  const XXXRoute() : super(XXXRoute.name, path: '/xxx');

  static const String name = 'XXXRoute';
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: '/register');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.HotPage]
class HotRoute extends _i11.PageRouteInfo<void> {
  const HotRoute() : super(HotRoute.name, path: '/hot');

  static const String name = 'HotRoute';
}

/// generated route for
/// [_i5.StockDetailPage]
class StockDetailRoute extends _i11.PageRouteInfo<StockDetailRouteArgs> {
  StockDetailRoute(
      {_i12.Key? key,
      required String id,
      required String name,
      required String close,
      required String vo,
      required String vo2,
      required String amount,
      required String date})
      : super(StockDetailRoute.name,
            path: '/stockDetailPage',
            args: StockDetailRouteArgs(
                key: key,
                id: id,
                name: name,
                close: close,
                vo: vo,
                vo2: vo2,
                amount: amount,
                date: date));

  static const String name = 'StockDetailRoute';
}

class StockDetailRouteArgs {
  const StockDetailRouteArgs(
      {this.key,
      required this.id,
      required this.name,
      required this.close,
      required this.vo,
      required this.vo2,
      required this.amount,
      required this.date});

  final _i12.Key? key;

  final String id;

  final String name;

  final String close;

  final String vo;

  final String vo2;

  final String amount;

  final String date;

  @override
  String toString() {
    return 'StockDetailRouteArgs{key: $key, id: $id, name: $name, close: $close, vo: $vo, vo2: $vo2, amount: $amount, date: $date}';
  }
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i11.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i12.Key? key})
      : super(HomeRoute.name, path: '/home', args: HomeRouteArgs(key: key));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.SaveSelectPage]
class SaveSelectRoute extends _i11.PageRouteInfo<void> {
  const SaveSelectRoute()
      : super(SaveSelectRoute.name, path: '/saveSelectPage');

  static const String name = 'SaveSelectRoute';
}

/// generated route for
/// [_i8.MoorPage]
class MoorRoute extends _i11.PageRouteInfo<void> {
  const MoorRoute() : super(MoorRoute.name, path: '/moor');

  static const String name = 'MoorRoute';
}

/// generated route for
/// [_i9.SearchStockPag]
class SearchStockPag extends _i11.PageRouteInfo<SearchStockPagArgs> {
  SearchStockPag({_i12.Key? key, required String pageRoute})
      : super(SearchStockPag.name,
            path: '/financeSearchPage',
            args: SearchStockPagArgs(key: key, pageRoute: pageRoute));

  static const String name = 'SearchStockPag';
}

class SearchStockPagArgs {
  const SearchStockPagArgs({this.key, required this.pageRoute});

  final _i12.Key? key;

  final String pageRoute;

  @override
  String toString() {
    return 'SearchStockPagArgs{key: $key, pageRoute: $pageRoute}';
  }
}

/// generated route for
/// [_i10.FinancePage]
class FinanceRoute extends _i11.PageRouteInfo<FinanceRouteArgs> {
  FinanceRoute({required String ts, _i12.Key? key})
      : super(FinanceRoute.name,
            path: '/financePage', args: FinanceRouteArgs(ts: ts, key: key));

  static const String name = 'FinanceRoute';
}

class FinanceRouteArgs {
  const FinanceRouteArgs({required this.ts, this.key});

  final String ts;

  final _i12.Key? key;

  @override
  String toString() {
    return 'FinanceRouteArgs{ts: $ts, key: $key}';
  }
}