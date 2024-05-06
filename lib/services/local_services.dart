import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:studenthub/utils/logger.dart';

class LocalStorageService {
  LocalStorageService();
  static const tokenKey = 'token';
  static const userInformationKey = 'userInformation';
  static const isFirstInstallKey = 'is-first-install';

  //Add more here when to save local storage

  Future<void> saveTokens({required String accessToken}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setString(tokenKey, accessToken);
      logger.i("Hoàn tất lưu token vào localStorage");
    } catch (e) {
      return;
    }
  }

  FutureOr<String?> getAccessToken() async {
    logger.i("Đang lấy token từ localStorage");
    final storage = await SharedPreferences.getInstance();
    return storage.getString(tokenKey);
  }

  FutureOr<void> clearToken() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(tokenKey);
    logger.i("Xoá token từ localStorage");
  }

  void saveUserInformation({required UserModel user}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setString(userInformationKey, user.toJson());
      logger.i("Hoàn tất lưu thong tin nguoi dung vào localStorage");
    } catch (e) {
      return;
    }
  }

  FutureOr<UserModel?> getUserInformation() async {
    final storage = await SharedPreferences.getInstance();
    logger.i("Đang lấy thong tin nguoi dung từ localStorage");
    return UserModel.fromJson(storage.getString(userInformationKey) ?? '');
  }

  FutureOr<void> setFirstInstall({required bool isFirstInstall}) async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setBool(isFirstInstallKey, isFirstInstall);
    } catch (e) {
      return;
    }
  }

  FutureOr<bool?> getFirstInstall() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getBool(isFirstInstallKey);
  }
}
