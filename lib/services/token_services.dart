import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub/utils/logger.dart';

class TokenService {
  TokenService();
  static const tokenKey = 'token';
  //Add more here when to save local storage

  void saveTokens({required String accessToken}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setString(tokenKey, accessToken);
      logger.i("Hoàn tất lưu token vào localStorage");
    } catch (e) {
      return;
    }
  }

  FutureOr<String?> getAccessToken() async {
    final storage = await SharedPreferences.getInstance();
    logger.i("Đang lấy token từ localStorage");
    return storage.getString(tokenKey);
  }

  void clearToken() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(tokenKey);
    logger.i("Xoá token từ localStorage");
  }

  // Add more here according template
}
