import 'dart:async' show Future, Timer;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  late bool authenticated;
  bool isLoading = false;

  setLoading(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = value;
      notifyListeners();
    });
  }

  setAuthenticated(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      authenticated = value;
      notifyListeners();
    });
  }

  initAuthentication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    if (token != null) {
      setAuthenticated(true);
    } else {
      setAuthenticated(false);
    }
  }

  Future<bool> login(Map userBody) async {
    setLoading(true);
    final response = await http.post(
        Uri.parse("http://172.20.10.9:8000/api/auth/login"),
        headers: {"Accept": "Application/json"},
        body: userBody);
    if (response.statusCode == 200) {
      // if success we have to generate to the user a new token .
      var decodedToken =
          json.decode(response.body)['access_token']; // this 2 lines
      final SharedPreferences prefs =
          await SharedPreferences.getInstance(); // this 2 lines
      prefs.setString('token', decodedToken);
      setLoading(false);
    }
    return true;
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
