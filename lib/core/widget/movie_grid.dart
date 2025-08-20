import 'package:flutter/material.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';
import 'package:flutter_moviedb/routes/router.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class MovieGrid extends StatelessWidget {
  MovieGrid({
    super.key,
    required this.hasReachedMax,
    required ScrollController scrollController,
    required this.movies,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Movie> movies;
  bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: hasReachedMax ? movies.length : movies.length + 1,
      itemBuilder: (context, index) {
        if (index >= movies.length) {
          return const Center(child: CircularProgressIndicator());
        }
    
        final movie = movies[index];
        final rating = movie.voteAverage / 10;
    
        return GestureDetector(
          onTap: () {
            context.push(RouterName.movieDetail, extra: movie);
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
  }
}