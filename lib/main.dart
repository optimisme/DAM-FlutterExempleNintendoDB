import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'app_data.dart';
import 'app.dart';

void main() async {

  // En aplicacions d'escriptori, cridar la funció 'showWindow'
  try {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      WidgetsFlutterBinding.ensureInitialized();
      await WindowManager.instance.ensureInitialized();
      windowManager.waitUntilReadyToShow().then(showWindow);
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  // Definir 'App' com el widget principal
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const App(),
    ),
  );
}

// Al mostrar la finestra d'aplicació,
// definir una mida de finestra mínima i el títol de la finestra
void showWindow (_) async {
    windowManager.setMinimumSize(const Size(300.0, 600.0));
    await windowManager.setTitle('App');
}