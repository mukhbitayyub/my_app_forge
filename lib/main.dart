import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app_forge/app.dart';
import 'package:my_app_forge/core/di/injection.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await GoogleFonts.pendingFonts([
      GoogleFonts.inter(),
    ]);

    await configureDependencies();

    FlutterError.onError = (details) {
      debugPrint(details.exceptionAsString());
    };

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('Uncaught asynchronous error: $error\n$stack');
  });
}
