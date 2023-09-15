import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/detailed_marvel_movie_model.dart';
import '../models/marvil_movie_model.dart';
import 'dart:convert';

class MoviesProvider with ChangeNotifier {
  List<MarvelMovieModel> movies = [];
  DetailedmarvelMovieModel? currentMovie;

  bool isLoading = true;
  bool isFailed = false;

  setLoading(bool status) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = status;
      notifyListeners();
    });
  }

  setFailed(bool status) {
    Timer(const Duration(milliseconds: 50), () {
      isFailed = status;
      notifyListeners();
    });
  }

  fetchMovies() async {
    setLoading(true);

    final response =
        await http.get(Uri.parse("https://mcuapi.herokuapp.com/api/v1/movies"));

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body)['data'];
      for (var x in decodedData) {
        movies.add(MarvelMovieModel.fromJson(x));
      }
    } else {
      setFailed(true);
    }

    setLoading(false);
  }

  fetchDetailedMovie(String movieId) async {
    setLoading(true);
    final response = await http
        .get(Uri.parse('https://mcuapi.herokuapp.com/api/v1/movies/$movieId'));

    if (response.statusCode == 200) {
      currentMovie =
          DetailedmarvelMovieModel.fromJson(jsonDecode(response.body));
      setFailed(false);
    } else {
      setFailed(true);
    }

    setLoading(false);
  }
}
