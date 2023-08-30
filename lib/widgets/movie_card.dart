import 'package:flutter/material.dart';
import 'package:marvel_app/models/marvil_movie_model.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key, required this.movieCardModel});
  final MarvelMovieModel movieCardModel;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "0"
                    "${((widget.movieCardModel.duration) / 60).toStringAsFixed(2).replaceAll(".", ":")}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'poppins',
                    ),
                  ),
                  Text(
                    widget.movieCardModel.title,
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
            widget.movieCardModel.coverUrl,
            fit: BoxFit.cover,
          )),
    );
  }
}
