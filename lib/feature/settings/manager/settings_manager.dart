import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:informat/feature/settings/model/settings_model.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingsManager extends StateNotifier<SettingsModel> {
  SettingsManager() : super(const SettingsModel()) {
    initSettingState();
  }
  late SettingsModel settingsModel;

  void initSettingState() async {
    final cacheManager = CacheManager.instance;
    final stringSettingState = await cacheManager.getPref(settingsKey);
    if (stringSettingState == null) {
      cacheManager.storePref(settingsKey, (const SettingsModel()).toJson);
    } else {
      settingsModel = SettingsModel.fromJson(stringSettingState);
    }
  }

  void changeTheme(ThemeMode mode) {
    if (mode == ThemeMode.light) {
      settingsModel = settingsModel.copyWith(isDark: false);
    } else {
      settingsModel = settingsModel.copyWith(isDark: true);
    }
    state = settingsModel;
    log(settingsModel);
    saveCurrentState();
  }

  void saveCurrentState() {
    final cacheManager = CacheManager.instance;
    cacheManager.storePref(settingsKey, settingsModel.toJson);
  }
}
