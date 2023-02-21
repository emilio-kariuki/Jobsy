import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

class HomeRepo {
  Future<bool> login(
      {required String email, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      SharedPreferencesManager().setLoggedIn(value: true);
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      SharedPreferencesManager().setLoggedIn(value: true);
      return false;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
