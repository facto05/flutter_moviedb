import 'package:flutter/material.dart';
import 'package:flutter_moviedb/core/domain/entity/movie/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'movie-${movie.id}',
                child: Image.network(
                  movie.posterPath,
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
                    movie.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )
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
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
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
                      Text(movie.releaseDate),
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
                    movie.overview,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),

                  // Additional details
                  if (movie.genres.isNotEmpty) ...[
                    Text(
                      'Genres',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: movie.genres
                          .map((genre) => Chip(label: Text(genre)))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Cast section
                  // Text(
                  //   'Cast',
                  //   style: Theme.of(context).textTheme.titleLarge,
                  // ),
                  // const SizedBox(height: 8),
                  // SizedBox(
                  //   height: 150,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: movie.cast.length,
                  //     itemBuilder: (context, index) {
                  //       final actor = movie.cast[index];
                  //       return Padding(
                  //         padding: const EdgeInsets.only(right: 16.0),
                  //         child: Column(
                  //           children: [
                  //             CircleAvatar(
                  //               radius: 40,
                  //               backgroundImage: actor.profilePath.isNotEmpty
                  //                   ? NetworkImage(actor.profilePath)
                  //                   : null,
                  //               child: actor.profilePath.isEmpty
                  //                   ? const Icon(Icons.person, size: 40)
                  //                   : null,
                  //             ),
                  //             const SizedBox(height: 8),
                  //             Text(actor.name),
                  //             Text(
                  //               actor.character,
                  //               style: const TextStyle(color: Colors.grey),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement favorite functionality
        },
        child: const Icon(Icons.favorite_border),
      ),
    );
  }
}