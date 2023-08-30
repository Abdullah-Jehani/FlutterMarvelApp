import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/const.dart';
import 'package:marvel_app/models/marvil_movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:marvel_app/widgets/custom_icon_button.dart';
import 'package:marvel_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MarvelMovieModel> movies = [];
  bool isLoading = false;
  fetchMovies() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse('https://mcuapi.herokuapp.com/api/v1/movies'));
    var decodedData = json.decode(response.body)['data'];
    for (var x in decodedData) {
      movies.add(MarvelMovieModel.fromJson(x));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: GridView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movieCardModel: movies[index]);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1 / 1.5),
                ),
              ));
  }
}
