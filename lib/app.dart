import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'ui/routes/app_route.gr.dart';

// c+p  Dart: Restart Analysis Server
class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
// flutter packages pub run build_runner build
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = useMemoized(() => AppRouter());

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: theme.data,
      darkTheme: AppTheme.dark().data,
      themeMode: themeMode,
      // locale: DevicePreview.locale(context),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
    );
  }
}
