import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/core/di/injection.dart';
import 'package:flutter_moviedb/core/domain/usecase/movie/get_movie_detail_usecase.dart';
import 'package:flutter_moviedb/presentation/movie_detail/bloc/movie_detail_event.dart';
import 'package:flutter_moviedb/presentation/movie_detail/bloc/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  
  final movieDetailUsecase = getIt<GetMovieDetailUsecase>();
  
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailFetch>(onFetchMovieDetail);
  }

  Future<void> onFetchMovieDetail(MovieDetailFetch event, Emitter<MovieDetailState> emit) async {
    try {
      emit(MovieDetailInitial());
      final movieDetail = await movieDetailUsecase.call(event.movieId);
      emit(MovieDetailLoaded(movieDetail));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}