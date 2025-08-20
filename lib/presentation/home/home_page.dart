import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';
import 'package:flutter_moviedb/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_moviedb/presentation/home/bloc/home_event.dart';
import 'package:flutter_moviedb/presentation/home/bloc/home_state.dart';
import 'package:flutter_moviedb/routes/router.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeLoadEvent()),
      child: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                // Now Playing Section
                _buildMovieSection(
                  context,
                  title: 'Now Playing',
                  movies: state.nowPlayingMovies.movies,
                ),

                // Popular Movies Section
                _buildMovieSection(
                  context,
                  title: 'Popular',
                  movies: state.popularMovies.movies,
                ),

                // Top Rated Section
                _buildMovieSection(
                  context,
                  title: 'Top Rated',
                  movies: state.topRatedMovies.movies,
                ),

                // Upcoming Movies Section
                _buildMovieSection(
                  context,
                  title: 'Upcoming',
                  movies: state.upcomingMovies.movies,
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Unknown state'));
      },
      listener: (context, state) {},
    );
  }

  Widget _buildMovieSection(
    BuildContext context, {
    required String title,
    required List<Movie> movies,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement "See All" functionality
                      if (title == 'Now Playing') {
                        context.push("/${RouterName.nowPlaying}");
                      }
                    },
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 240, // Increased height to accommodate rating bar
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      context.goNamed(
                        RouterName.movieDetail,
                        pathParameters: {'movieId': movie.id.toString()},
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Hero(
                                      tag: 'movies-${movie.id}',
                                      child: Image.network(
                                        movie.posterPath,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey[300],
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                    ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                  // Rating badge in top-right corner
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            movie.voteAverage.toStringAsFixed(
                                              1,
                                            ),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Movie title
                            Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Rating progress bar
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Rating: ${movie.voteAverage.toStringAsFixed(1)}/10',
                            //       style: const TextStyle(
                            //         fontSize: 10,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //     const SizedBox(height: 2),
                            //     SizedBox(
                            //       height: 6,
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(3),
                            //         child: LinearProgressIndicator(
                            //           value: rating,
                            //           backgroundColor: Colors.grey[300],
                            //           valueColor: AlwaysStoppedAnimation<Color>(
                            //               ratingColor),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color _getRatingColor(double rating) {
  //   if (rating >= 0.7) return Colors.green; // 7+ rating
  //   if (rating >= 0.5) return Colors.orange; // 5-6.9 rating
  //   return Colors.red; // Below 5 rating
  // }
}
