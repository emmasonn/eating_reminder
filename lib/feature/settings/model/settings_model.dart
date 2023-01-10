import 'dart:convert';

import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final bool isDarkTheme;
  const SettingsModel({
    this.isDarkTheme = false,
  });

  factory SettingsModel.fromJson(String source) {
    final data = json.decode(source);
    return SettingsModel(
      isDarkTheme: data['isDark'],
    );
  }

  String get toJson {
    return json.encode({
      'isDark': isDarkTheme,
    });
  }

  SettingsModel copyWith({
    bool? isDark,
  }) {
    return SettingsModel(isDarkTheme: isDark ?? isDarkTheme);
  }

  @override
  List<Object?> get props => [
        isDarkTheme,
      ];
}
