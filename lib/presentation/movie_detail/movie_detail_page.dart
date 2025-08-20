import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/presentation/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:flutter_moviedb/presentation/movie_detail/bloc/movie_detail_event.dart';
import 'package:flutter_moviedb/presentation/movie_detail/bloc/movie_detail_state.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc()..add(MovieDetailFetch(movieId)),
      child: MovieDetailSection(),
    );
  }
}

class MovieDetailSection extends StatelessWidget {
  const MovieDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailError) {
            return Center(child: Text(state.message));
          } else if (state is MovieDetailLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'movie-${state.movie.id}',
                      child: Image.network(
                        state.movie.posterPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          state.movie.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Rating and basic info
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    state.movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 4),
                            Text(state.movie.releaseDate),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Overview
                        Text(
                          'Overview',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.movie.overview,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),

                        // Additional details
                        if (state.movie.genres.isNotEmpty) ...[
                          Text(
                            'Genres',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: state.movie.genres
                                .map((genre) => Chip(label: Text(genre.name)))
                                .toList(),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          }else{
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
