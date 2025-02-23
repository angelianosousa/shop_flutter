import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/services.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiresAt;
  Timer? _signOutTimer;

  bool get userIsAuth {
    final authTokenValid = _expiresAt?.isAfter(DateTime.now()) ?? false;

    return _token != null && authTokenValid;
  }

  String? get token => userIsAuth ? _token : null;
  String? get email => userIsAuth ? _email : null;
  String? get userId => userIsAuth ? _userId : null;

  Future<void> _authenticate(
    String email,
    String password,
    String apiMethod,
  ) async {
    final authUrl = '${Services.baseAuthUrl}:$apiMethod?key=${Services.apiKey}';

    final response = await post(
      Uri.parse(authUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final responseBody = jsonDecode(response.body);

    if (responseBody['error'] != null) {
      throw AuthException(responseBody['error']['message']);
    } else {
      _token = responseBody['idToken'];
      _email = responseBody['email'];
      _userId = responseBody['localId'];
      _expiresAt = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expiresAt': _expiresAt!.toIso8601String(),
      });

      _autoSignOut();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (userIsAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    final expiresAt = DateTime.parse(userData['expiresAt']);
    if (expiresAt.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiresAt = expiresAt;

    _autoSignOut();
    notifyListeners();
  }

  Future<void> signOut() async {
    _token = null;
    _email = null;
    _userId = null;
    _expiresAt = null;

    _clearSignOutTimer();
    Store.remove('userData').then((_) => notifyListeners());
  }

  void _clearSignOutTimer() {
    _signOutTimer?.cancel();
    _signOutTimer = null;
  }

  void _autoSignOut() {
    _clearSignOutTimer();
    final timeToSignOut = _expiresAt?.difference(DateTime.now()).inSeconds;
    _signOutTimer = Timer(Duration(seconds: timeToSignOut ?? 0), signOut);
  }
}
