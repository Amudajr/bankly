import 'package:bankly/utils/theme.dart';
import 'package:bankly/views/landing_page/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Banklyy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF',
        scaffoldBackgroundColor: SCAFFOLD_COLOR,
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}
