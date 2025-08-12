import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_bloc.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_event.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_state.dart';
import 'package:flutter_moviedb/routes/router.dart';
import 'package:go_router/go_router.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingBloc()..add(FetchNowPlayingMovies()),
      child: const NowPlayingWidget(),
    );
  }
}

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget({super.key});

  @override
  State<NowPlayingWidget> createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NowPlayingBloc>().add(FetchNowPlayingMovies());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing'), centerTitle: true),
      body: BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, state) {
          if (state is NowPlayingInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NowPlayingLoading && state.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NowPlayingError) {
            return Center(child: Text(state.message));
          }

          final movies = state.movies;

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.hasReachedMax ? movies.length : movies.length + 1,
            itemBuilder: (context, index) {
              if (index >= movies.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final movie = movies[index];
              final rating = movie.voteAverage / 10;

              return GestureDetector(
                onTap: () {
                  context.goNamed(
                    RouterName.movieDetail,
                    extra: movie,
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Hero(
                            tag: 'movie-${movie.id}',
                            child: Image.network(
                              movie.posterPath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.broken_image),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(movie.voteAverage.toStringAsFixed(1)),
                                const Spacer(),
                                Text(
                                  movie.releaseDate.split('-')[0],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: rating,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                rating >= 0.7
                                    ? Colors.green
                                    : rating >= 0.5
                                    ? Colors.orange
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}