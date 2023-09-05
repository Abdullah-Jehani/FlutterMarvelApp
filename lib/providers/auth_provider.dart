import 'dart:async' show Future, Timer;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
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

  Future<List> login(Map userBody, BuildContext context) async {
    setLoading(true);
    final response = await http.post(
      Uri.parse("https://api.ha-k.ly/api/v1/client/auth/login"),
      body: json.encode(userBody),
      headers: {
        "Accept": "Application/json",
        "content-type": "Application/json"
      },
    );
    if (response.statusCode == 201) {
      setAuthenticated(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      if (kDebugMode) {
        print(" Response Status${response.statusCode}");
      }
      if (kDebugMode) {
        print(" Response Body ${userBody}");
      }
      return [true, ''];
    } else {
      setAuthenticated(false);
      if (kDebugMode) {
        print(" Response Status${response.statusCode}");
      }
      if (kDebugMode) {
        print(" Response Body ${userBody}");
      }
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> register(Map userBody, BuildContext context) async {
    setLoading(true);
    final response = await http.post(
      Uri.parse("https://api.ha-k.ly/api/v1/client/auth/register"),
      body: json.encode(userBody),
      headers: {
        "Accept": "Application/json",
        "content-type": "Application/json"
      },
    );
    if (response.statusCode == 201) {
      setAuthenticated(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      if (kDebugMode) {
        print(" Response Status${response.statusCode}");
      }
      if (kDebugMode) {
        print(" Response Body ${userBody}");
      }
      return [true, ''];
    } else {
      setAuthenticated(false);
      if (kDebugMode) {
        print(" Response Status${response.statusCode}");
      }
      if (kDebugMode) {
        print(" Response Body ${userBody}");
      }
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
