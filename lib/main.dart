import 'package:conf_app/pages/add_event_page.dart';
import 'package:conf_app/pages/home_page.dart';
import 'package:conf_app/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('fr_FR').then((_) {
    runApp(const ConferenceApp());
  });

}

class ConferenceApp extends StatelessWidget {
  const ConferenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/list': (context) => ListPage(),
        '/add': (context) => AddEventPage(),
      },
    );
  }
}
