import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:nb_utils/nb_utils.dart';

class ThemeManager extends StateNotifier<String> {
  ThemeManager() : super(lightTheme) {
    initSettingState();
  }

  final CacheManager cacheManager = CacheManager.instance;
  String currentTheme = lightTheme;

  void initSettingState() async {
    final stringSettingState = await cacheManager.getPref(themeKey);
    if (stringSettingState == null) {
      //initialize the cache
      cacheManager.storePref(themeKey, lightTheme);
    } else {
      currentTheme = stringSettingState as String;
    }
    state = currentTheme;
  }

  void changeTheme(ThemeMode mode) {
    if (mode == ThemeMode.light) {
      currentTheme = lightTheme;
    } else {
      currentTheme = darkTheme;
    }
    state = currentTheme;
    saveCurrentState();
  }

  void saveCurrentState() {
    cacheManager.storePref(themeKey, currentTheme);
  }
}
