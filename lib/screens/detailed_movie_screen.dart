import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:marvel_app/helpers/const.dart';
import 'package:marvel_app/helpers/helper_function.dart';
import 'package:marvel_app/models/marvil_movie_model.dart';
import 'package:marvel_app/providers/movie_provider.dart';

import 'package:provider/provider.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class DetailedMovieScreen extends StatefulWidget {
  const DetailedMovieScreen({super.key, required this.marvelMovieModel});
  final MarvelMovieModel marvelMovieModel;
  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false)
        .fetchDetailedMovie(widget.marvelMovieModel.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (context, moviesConsumer, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: moviesConsumer.isLoading
            ? null
            : AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                title: Text(
                  moviesConsumer.currentMovie!.title.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
        body: Center(
          child: moviesConsumer.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Divider(
                            color: Colors.red.withOpacity(0.3),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                      moviesConsumer.currentMovie!.coverUrl)),
                            ),
                            const Positioned(
                              top: 50,
                              right: 50,
                              child: Padding(
                                padding: EdgeInsets.all(34.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/video-play.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(moviesConsumer.currentMovie!.directedBy
                                .toString())
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/clock.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(fromIntToDuration(
                                moviesConsumer.currentMovie!.duration))
                          ],
                        ),
                        if (moviesConsumer.currentMovie!.overview != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Text(moviesConsumer.currentMovie!.overview
                                  .toString()),
                            ],
                          ),
                        if (moviesConsumer.currentMovie!.trailerUrl != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: primaryColor),
                                  child: TextButton(
                                    child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Watch Trailer',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontFamily: 'poppins'),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Iconify(
                                              Heroicons.play,
                                              color: Colors.white,
                                              size: 24,
                                            )
                                          ],
                                        )),
                                    onPressed: () async {
                                      launcher.launchUrl(
                                        Uri.parse((moviesConsumer
                                            .currentMovie!.trailerUrl
                                            .toString())),
                                        mode: launcher
                                            .LaunchMode.externalApplication,
                                      );
                                      if (kDebugMode) {
                                        print(' STATUS : clicked');
                                      }
                                    },
                                  )),
                            ],
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
