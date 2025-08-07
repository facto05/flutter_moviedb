import 'package:flutter_moviedb/core/domain/entity/movie/movie_list.dart';
import 'package:flutter_moviedb/core/domain/repository/movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class UpcomingMovieUsecase {
  final MovieRepository movieRepository;

  UpcomingMovieUsecase(this.movieRepository);

  Future<MovieList> call(int page) {
    return movieRepository.getUpcomingMovies(page);
  }
}