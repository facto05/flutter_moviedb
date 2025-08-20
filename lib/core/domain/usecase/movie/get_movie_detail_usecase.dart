import 'package:flutter_moviedb/core/domain/entity/movie/movie_detail.dart';
import 'package:flutter_moviedb/core/domain/repository/movie_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetMovieDetailUsecase {
  final MovieRepository movieRepository;

  GetMovieDetailUsecase(this.movieRepository);

  Future<MovieDetail> call(int movieId) async {
    return await movieRepository.getMovieDetail(movieId);
  }
}