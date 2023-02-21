import 'package:jobsy_flutter/Ui/Utilities/GlobalConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  Future<bool> isLoggedIn() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(IS_LOGGED_IN) ?? false;
  }

  Future setLoggedIn({required bool value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setBool(IS_LOGGED_IN, value);
  }


}
