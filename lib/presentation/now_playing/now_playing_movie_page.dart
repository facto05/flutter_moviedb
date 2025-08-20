import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/core/widget/movie_grid.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_bloc.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_event.dart';
import 'package:flutter_moviedb/presentation/now_playing/bloc/now_playing_state.dart';

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

          return MovieGrid(
            scrollController: _scrollController,
            movies: movies,
            hasReachedMax: state.hasReachedMax,
          );
        },
      ),
    );
  }
}
