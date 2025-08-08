import 'package:flutter_moviedb/presentation/home/home_page.dart';
import 'package:go_router/go_router.dart';

part 'router_name.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouterName.home,
      builder: (context, state) => HomePage(),
    )
  ]
);