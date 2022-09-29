import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

///* Storage Keys starting with `app_` (i.e. app_[key_name]) are termed
///* [App-wide] keys and must not be cleared on User actions within the
///* application, unless when manually cleared from Phone Setting, while
///* [User-based] keys are declared normally with no prefixes (i.e. [key_name])

class CacheManager {
  //Static variable as a single entrypoint to this class
  static final CacheManager instance = CacheManager._();

  Future<SharedPreferences>? _sharedPref;

  ///private Constructor
  CacheManager._() {
    //Initialize SharedPrefrences
    init();
  }

  ///SharedPreferences initializer
  void init() {
    _sharedPref = SharedPreferences.getInstance();
  }

  ///Storage Agent
  ///* Stores an entry with a given [key] and [value] in the persistent storage
  Future<bool> storePref(String key, dynamic value) async {
    if (value is String) {
      return (await _sharedPref)!.setString(key, value);
    } else if (value is int) {
      return (await _sharedPref)!.setInt(key, value);
    } else if (value is double) {
      return (await _sharedPref)!.setDouble(key, value);
    } else if (value is List<String>) {
      return (await _sharedPref)!.setStringList(key, value);
    } else if (value is bool) {
      return (await _sharedPref)!.setBool(key, value);
    } else {
      throw const FormatException();
    }
  }

  ///Value Retriever
  ///* Retrieves an entry with the given [key] from persistent storage
  Future<dynamic> getPref(String key) async {
    return (await _sharedPref)!.get(key);
  }

  ///Remove all entries from persistent storage that are not [app-wide]
  Future<void> clearPrefs() async {
    (await _sharedPref)!.getKeys().forEach((key) async {
      //Check whether key is [App-wide] or [User-based]
      if (!key.contains('app_')) {
        (await _sharedPref)!.remove(key);
      }
    });
  }

  ///Remove an with [key] from persistent storage
  ///that is not [app-wide]
  Future<void> clearPref(String key) async {
    (await _sharedPref)!.getKeys().forEach((key) async {
      //Check whether key is [App-wide] or [User-based]
      if (!key.contains('app_')) {
        (await _sharedPref)!.remove(key);
      }
    });
  }

  /// Removes all preferences for this app from persistent storage
  Future<bool> clearCache() async {
    return (await _sharedPref)!.clear();
  }

  Future<bool> checkPref(String key) async {
    return (await _sharedPref)!.containsKey(key) &&
        (await _sharedPref)!.getString(key) != null;
  }

  Future<dynamic> readPrefFromObject(String key1, String key2) async {
    if (await checkPref(key1)) {
      final decodedString =
          await json.decode((await _sharedPref)!.getString(key1)!);

      final result = decodedString[key2];

      return result;
    } else {
      return null;
    }
  }
}
