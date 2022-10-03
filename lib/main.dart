import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app.dart';

//編譯器執行
// flutter run --no-sound-null-safety
//打包apk
//flutter build apk --release --no-sound-null-safety
//程式入口點
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: ResponsiveSizer(
          builder: (context, orientation, deviceType) => const MyApp()),
    ),
  );
}
