import 'package:flutter_moviedb/presentation/home/home_page.dart';
import 'package:flutter_moviedb/presentation/movie_detail/movie_detail_page.dart';
import 'package:flutter_moviedb/presentation/now_playing/now_playing_movie_page.dart';
import 'package:go_router/go_router.dart';

part 'router_name.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouterName.home,
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: RouterName.nowPlaying,
          builder: (context, state) => const NowPlayingPage(),
        ),
        GoRoute(
          path: RouterName.movieDetail,
          builder: (context, state) {
            final movieId = int.parse(state.pathParameters['movieId']!);
            return MovieDetailPage(movieId: movieId);
          },
        ),
      ],
    ),
  ],
);
