import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_moviedb/core/di/injection.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';
import 'package:flutter_moviedb/core/domain/usecase/movie/now_playing_movie_usecase.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_event.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final nowPlayingMovieUsecase = getIt<NowPlayingMovieUsecase>();
  int currentPage = 1;
  bool hasReachedMax = false;

  NowPlayingBloc() : super(NowPlayingInitial()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMovies event,
    Emitter<NowPlayingState> emit,
  ) async {
    if (hasReachedMax) return;

    try {
      if (currentPage == 1) {
        emit(NowPlayingLoading());
      }

      final result = await nowPlayingMovieUsecase.call(currentPage);
      hasReachedMax = result.movies.isEmpty;

      final updatedMovies = [...state.movies, ...result.movies];

      final uniqueMovies = _removeDuplicateMovie(updatedMovies);

      emit(
        NowPlayingLoaded(
          movies: uniqueMovies,
          hasReachedMax: result.movies.isEmpty,
        ),
      );
      currentPage++;
    } catch (e) {
      emit(NowPlayingError(e.toString()));
    }
  }

  List<Movie> _removeDuplicateMovie(List<Movie> movies){
    final seen = <String>{};
    return movies.where((movie) => seen.add(movie.id)).toList();
  }
}
