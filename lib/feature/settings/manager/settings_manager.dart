import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:informat/feature/settings/model/settings_model.dart';

class SettingsManager extends StateNotifier<SettingsModel> {
  SettingsManager() : super(const SettingsModel()) {
    initSettingState();
  }
  late SettingsModel settingsModel;

  void initSettingState() async {
    final cacheManager = CacheManager.instance;
    final stringSettingState = await cacheManager.getPref(settingsKey);
    if (stringSettingState == null) {
      //initialize the cache
      const initialSettingsState = SettingsModel();
      cacheManager.storePref(settingsKey, initialSettingsState.toJson);
      settingsModel = initialSettingsState;
    } else {
      //parse the cached settings state
      settingsModel = SettingsModel.fromJson(stringSettingState);
    }
    state = settingsModel;
  }

  void changeTheme(ThemeMode mode) {
    if (mode == ThemeMode.light) {
      settingsModel = settingsModel.copyWith(isDark: false);
    } else {
      settingsModel = settingsModel.copyWith(isDark: true);
    }
    state = settingsModel;
    saveCurrentState();
  }

  void saveCurrentState() {
    final cacheManager = CacheManager.instance;
    cacheManager.storePref(settingsKey, settingsModel.toJson);
  }
}
