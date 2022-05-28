import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

import 'package:tutor_raya_mobile/models/user.dart';
import 'package:tutor_raya_mobile/services/google_signin_api.dart';
import 'package:tutor_raya_mobile/utils/constants.dart';

// import 'package:flutter_todo/widgets/notification_text.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  late String _token;
  User? _user;
  // NotificationText _notification;

  Status get status => _status;
  String get token => _token;
  User? get user => _user;
  // NotificationText get notification => _notification;

  initAuthProvider() async {
    String? token = await getToken();
    User? user = await getUser();
    if (token != null && user != null) {
      _token = token;
      _user = user;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login() async {
    _status = Status.Authenticating;
    notifyListeners();

    final user = await GoogleSignInApi.login();
    if (user == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
      Toast.show("Login Failed",
          duration: Toast.lengthLong, gravity: Toast.bottom);
      return false;
    }

    final url = Uri.parse("$API_ROOT/login/mobile");

    Map<String, String> body = {
      'email': user.email,
      'name': user.displayName!,
    };

    final response = await http
        .post(url, body: body, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200 && response.headers['api_token'] != null) {
      Map<String, dynamic> apiResponse = json.decode(response.body)[0];
      _status = Status.Authenticated;
      _token = response.headers['api_token']!;
      _user = User.fromJson(apiResponse);
      print(_token);
      await storeUserData(apiResponse, _token);
      notifyListeners();
      Toast.show("Login Successfull",
          duration: Toast.lengthLong, gravity: Toast.bottom);
      return true;
    }

    _status = Status.Unauthenticated;
    Toast.show("Login Failed",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    notifyListeners();
    return false;
  }

  Future<bool> updateAbout(
      String? about, String? education, String? phoneNumber) async {
    final url = Uri.parse("$API_ROOT/users/${_user?.id}/profile");

    Map<String, String> body = {
      'about': about ?? "",
      'education': education ?? "",
      'phone_number': phoneNumber ?? ""
    };

    final response = await http.put(
      url,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(response.body)['data'];
      _user = User.fromJson(apiResponse);
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.remove('user');
      await storage.setString('user', json.encode(_user));

      notifyListeners();

      return false;
    }

    return false;
  }

  storeUserData(apiResponse, token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', token);
    await storage.setString('user', json.encode(_user));
  }

  Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }

  Future<User?> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final userData = storage.getString('user');
    print(userData);
    if (userData != null) {
      Map<String, dynamic> userMap = json.decode(userData);
      print('map' + userMap.toString());
      return User.fromJson(userMap);
    }
    return null;
  }

  logOut() async {
    final url = Uri.parse("$API_ROOT/logout");
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        'Accept': 'application/json'
      },
    );
    print(response.body);
    if (response.statusCode != 200) {
      Toast.show("Logout Failed",
          duration: Toast.lengthLong, gravity: Toast.bottom);
      return;
    }

    await GoogleSignInApi.logout();
    _status = Status.Unauthenticated;
    _user = null;

    Toast.show("Logout Successfull",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
    notifyListeners();
  }
}
