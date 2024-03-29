import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  TokenService();
  static const tokenKey = 'token';
  //Add more here when to save local storage

  void saveTokens({required String accessToken}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setString(tokenKey, accessToken);
    } catch (e) {
      return;
    }
  }

  FutureOr<String?> getAccessToken() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(tokenKey);
  }

  void clearToken() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(tokenKey);
  }

  // Add more here according template
}
