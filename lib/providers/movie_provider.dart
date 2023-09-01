import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/marvil_movie_model.dart';
import 'dart:convert';

class MoviesProvider with ChangeNotifier {
  List<MarvelMovieModel> movies = [];
  bool isLoading = false;
  bool isFailed = false;
  // the function is used to set a loading state
  setLoading(bool status) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = status;
      notifyListeners();
    });
  }

  fetchMovies() async {
    setLoading(true);
    final response =
        await http.get(Uri.parse('https://mcuapi.herokuapp.com/api/v1/movies'));
    var decodedData =
        json.decode(response.body)['data']; // decode data from text to Json
    for (var x in decodedData) {
      movies.add(MarvelMovieModel.fromJson(
          x)); // to specify its coming as a json an dconverted to dart
    }

    setLoading(false);
  }
}
