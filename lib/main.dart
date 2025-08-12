import 'package:flutter/material.dart';
import 'package:flutter_moviedb/core/di/injection.dart';
import 'package:flutter_moviedb/routes/router.dart';

void main() async {
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
