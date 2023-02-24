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

  Future setUserId({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_ID, value);
  }

  Future<String> getUserId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_ID) ?? "";
  }

  Future setUserName({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_NAME, value);
  }

  Future<String> getUserName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_NAME) ?? "";
  }

  Future setUserEmail({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_EMAIL, value);
  }

  Future<String> getUserEmail() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_EMAIL) ?? "";
  }

  Future setUserPhone({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_PHONE, value);
  }

  Future<String> getUserPhone() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_PHONE) ?? "";
  }

  Future setUserImage({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_IMAGE, value);
  }

  Future<String> getUserImage() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_IMAGE) ?? "";
  }

  Future setUserLocation({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_LOCATION, value);
  }

  Future<String> getUserLocation() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_LOCATION) ?? "";
  }

  Future setRole({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(USER_ROLE, value);
  }

  Future<String> getRole() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(USER_ROLE) ?? "home";
  }

  







}
