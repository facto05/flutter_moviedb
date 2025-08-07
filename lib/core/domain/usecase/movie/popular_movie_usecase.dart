import 'package:flutter_moviedb/core/domain/entity/movie/movie_list.dart';
import 'package:flutter_moviedb/core/domain/repository/movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class PopularMovieUsecase {
  final MovieRepository movieRepository;

  PopularMovieUsecase(this.movieRepository);

  Future<MovieList> call(int page) async {
    return await movieRepository.getPopularMovies(page);
  }
}