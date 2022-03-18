import 'dart:convert';

import 'package:flutter_box/box_framework/data/box_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferencesBox {
  Future<void> putString(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$key', val);
  }

  Future<String?> getString(key) async {
    final prefs = await SharedPreferences.getInstance();
    var _res = prefs.getString('$key');
    return _res;
  }

  Future<void> putStringList(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('$key', val);
  }

  Future<List<String>?> getStringList(key) async {
    final prefs = await SharedPreferences.getInstance();
    var _res = prefs.getStringList('$key');
    return _res;
  }

  Future<void> putInt(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$key', val);
  }

  Future<int?> getInt(key) async {
    final prefs = await SharedPreferences.getInstance();
    var _res = prefs.getInt('$key');
    return _res;
  }

  Future<void> putBoolean(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$key', val);
  }

  Future<bool?> getBoolean(key) async {
    final prefs = await SharedPreferences.getInstance();
    var _res = prefs.getBool('$key');
    return _res;
  }

  Future<void> putDouble(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$key', val);
  }

  Future<double?> getDouble(key) async {
    final prefs = await SharedPreferences.getInstance();
    var _res = prefs.getDouble('$key');
    return _res;
  }

  Future<void> putJson(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    var valString = jsonEncode(val);
    await prefs.setString('$key', valString);
  }

  Future<Map?> getJson(key) async {
    final pref = await SharedPreferences.getInstance();
    var valString = pref.getString('$key')!;
    Map? map = jsonDecode(valString) as Map<String, dynamic>?;
    return map;
  }

  Future<void> removeValueFromSharedPreference(key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$key');
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> putObject<T extends BoxModel>(T model) async {
    model.toString();
  }
}

abstract class SharedPreferencesKeys {
  static const String ACCESS_TOKEN = "accessToken";
  static const REFRESH_TOKEN = "refreshToken";
  static const FIREBASE_TOKEN = "firebaseToken";
  static const USER_NAME = "userName";
  static const MOBILE = "mobileNumber";
  static const ID = "userId";
  static const USER_TYPE = "userType";
  static const IS_ON_BOARDED = "isOnboarded";
  static const IS_SIGNED_IN = "isSignedIn";
  static const PROFILE_PIC = "profilePic";
  static const IS_GUEST_USER = "isGuestUser";
  static const IS_WHATSAPP_SUBSCRIBED = "is_whatsapp_subscribed";
  static const IS_FROM_REJECTED_COURSE = "is_from_rejected_course";

  static const SUMMARY = "summary";
  static const HIGHEST_QUALIFICATION = "HIGHEST_QUALIFICATION";
  static const TEACHING_DOMAINS = "teaching_domains";
  static const TEACHING_DOMAINS_ALL = "teaching_domains_all";
  static const PROFILE_STATUS = "profile_status";
  static const REJECTION_REASON = "rejection_reason";
  static const USER_MODEL = "user_model";
  static const ID_PROOF_NAME = "id_proof_name";
  static const CERT_URLS = "cert_urls";
  static const ID_PROOF_URL = "id_proof_url";
  static const VIDEO_URL = "video_url";
  static const PROFILE_PHOTO_URL = "profile_photo_url";

  static const WORK_STATUS = "work_status";
  static const ENROLED_COURSES = "enroled_courses";
  static const INTERESTS = "interests";

  static const DOB = "dob";
  static const LANGUAGES = "languages";

  static const REJECTION_STATUS = "rejection_status";
}
