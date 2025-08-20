abstract class MovieDetailEvent {}

class MovieDetailFetch extends MovieDetailEvent {
  final int movieId;

  MovieDetailFetch(this.movieId);
}