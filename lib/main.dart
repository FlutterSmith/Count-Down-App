import 'dart:io';
import 'package:countdown_app/services/notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
// Initialize FFI on desktop platforms.
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'providers/event_provider.dart';
import 'screens/event_list_screen.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // If running on desktop (Windows, Linux, macOS), initialize the FFI implementation.
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Initialize the notification service.
  await NotificationService().init();

  // Run the real app.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventProvider>(
      create: (_) => EventProvider(),
      child: MaterialApp(
        title: 'Countdown App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: EventListScreen(),
      ),
    );
  }
}
