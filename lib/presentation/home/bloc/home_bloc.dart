import 'package:bloc/bloc.dart';
import 'package:flutter_moviedb/core/di/injection.dart';
import 'package:flutter_moviedb/core/domain/usecase/movie/now_playing_movie_usecase.dart';
import 'package:flutter_moviedb/core/domain/usecase/movie/popular_movie_usecase.dart';
import 'package:flutter_moviedb/core/domain/usecase/movie/top_rated_movie_usecase.dart';
import 'package:flutter_moviedb/core/domain/usecase/movie/upcoming_movie_usecase.dart';
import 'package:flutter_moviedb/presentation/home/bloc/home_event.dart';
import 'package:flutter_moviedb/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  final nowPlayingMovieUsecase = getIt<NowPlayingMovieUsecase>();
  final popularMovieUsecase = getIt<PopularMovieUsecase>();
  final topRatedMovieUsecase = getIt<TopRatedMovieUsecase>();
  final upcomingMovieUsecase = getIt<UpcomingMovieUsecase>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadEvent>((event, emit) async {
      var nowPlayingMovies = await nowPlayingMovieUsecase.call(event.page);
      var popularMovies = await popularMovieUsecase.call(event.page);
      var topRatedMovies = await topRatedMovieUsecase.call(event.page);
      var upcomingMovies = await upcomingMovieUsecase.call(event.page);
      emit(HomeLoaded(
        nowPlayingMovies: nowPlayingMovies,
        popularMovies: popularMovies,
        topRatedMovies: topRatedMovies,
        upcomingMovies: upcomingMovies,
      ));
    });
  }

}