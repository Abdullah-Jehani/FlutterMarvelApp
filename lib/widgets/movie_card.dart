import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/models/marvil_movie_model.dart';
import 'package:marvel_app/screens/detailed_movie_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movieCard});
  final MarvelMovieModel movieCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    DetailedMovieScreen(marvelMovieModel: movieCard)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
              footer: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black87, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "0"
                        "${((movieCard.duration) / 60).toStringAsFixed(2).replaceAll(".", ":")}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'poppins',
                        ),
                      ),
                      Text(
                        movieCard.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Image.network(
                movieCard.coverUrl,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
