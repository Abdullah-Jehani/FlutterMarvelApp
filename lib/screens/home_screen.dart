import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/const.dart';
import 'package:marvel_app/providers/movie_provider.dart';

import 'package:marvel_app/widgets/custom_icon_button.dart';
import 'package:marvel_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MoviesProvider>(builder: (context, movie, child) {
      return Scaffold(
          drawer: const Drawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/marvel_logo.png',
              width: size.width * .25,
            ),
            actions: [
              CustomIconButton(
                  asset: "assets/icons/dm.png",
                  color: primaryColor,
                  onpressed: () {}),
              CustomIconButton(
                  asset: "assets/icons/heart_outlined.png",
                  color: primaryColor,
                  onpressed: () {})
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: GridView.builder(
              itemCount: movie.isLoading ? 20 : movie.movies.length,
              itemBuilder: (context, index) {
                return movie.isLoading
                    ? Container(
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            border: Border.all(
                                color: primaryColor.withOpacity(0.3)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: SizedBox(
                          child: Shimmer.fromColors(
                              baseColor: primaryColor.withOpacity(0.2),
                              highlightColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                              )),
                        ),
                      )
                    : MovieCard(movieCardModel: movie.movies[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1 / 1.5),
            ),
          )

          //  Center(
          //     child: CircularProgressIndicator(
          //       color: primaryColor,
          //     ),
          //   )
          );
    });
  }
}
