import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game2048flutter/types/game_palette.dart';
import 'package:game2048flutter/util/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides user preferences
class SettingsProvider with ChangeNotifier {
  SettingsProvider._(
      GamePalette palette, bool darkMode, bool autoReset, bool musicMode)
      : _palette = palette ?? GamePalette.classic,
        _darkMode = darkMode ?? false,
        _autoReset = autoReset ?? true,
        _musicMode = musicMode ?? false {
    if (palette == null) {
      _savePreference('palette', GamePalette.classic.name);
    }

    if (darkMode == null) {
      _savePreference('darkMode', false);
    }

    if (autoReset == null) {
      _savePreference('autoReset', true);
    }

    if (musicMode == null) {
      _savePreference('musicMode', false);
      //TODO Burda  false eks olaraq true olaraq yoxsa app begin etse music ON olacaq;
    }
  }

  /// Loads settings from [SharedPreferences]
  factory SettingsProvider.load(SharedPreferences preferences) {
    final loadedPalette = Palette.getGamePaletteByName(
      preferences.getString('palette'),
    );
    final loadedDarkMode = preferences.getBool('darkMode');
    final loadedAutoReset = preferences.getBool('autoReset');
    final loadedMusicMode = preferences.getBool('musicMode');

    if (_instance == null) {
      return _instance ??= SettingsProvider._(
          loadedPalette, loadedDarkMode, loadedAutoReset, loadedMusicMode);
    }

    _instance.palette = loadedPalette;
    _instance.darkMode = loadedDarkMode;
    _instance.autoReset = loadedAutoReset;
    _instance.musicMode = loadedMusicMode;

    return _instance;
  }

  static SettingsProvider _instance;

  GamePalette _palette;
  bool _darkMode;
  bool _autoReset;
  bool _musicMode;

  static void _savePreference(String name, dynamic value) {
    SharedPreferences.getInstance().then((preferences) {
      if (value is bool) {
        preferences.setBool(name, value);
      } else if (value is String) {
        preferences.setString(name, value);
      } else if (value is int) {
        preferences.setInt(name, value);
      } else if (value is double) {
        preferences.setDouble(name, value);
      } else if (value is List<String>) {
        preferences.setStringList(name, value);
      } else {
        throw Exception('${value.runtimeType} may not be saved directly');
      }
    });
  }

  /// Whether the app should use [ThemeMode.dark]
  bool get darkMode => _darkMode;

  bool get musicMode => _musicMode;

  set darkMode(bool value) {
    if (value == null) return;

    if (value == _darkMode) return;

    if (_darkMode != null) {
      _darkMode = value;

      _savePreference('darkMode', _darkMode);

      notifyListeners();
    } else {
      _darkMode = value;
    }
  }

  set musicMode(bool value) {
    if (value == null) return;

    if (value == _musicMode) return;

    if (_musicMode != null) {
      _musicMode = value;

      _savePreference('musicMode', _musicMode);

      notifyListeners();
    } else {
      _musicMode = value;
    }
  }

  /// The preferred [GamePalette]
  GamePalette get palette => _palette;

  set palette(GamePalette value) {
    if (value == null) return;

    if (value == _palette) return;

    _palette = value;

    _savePreference('palette', _palette.name.toLowerCase());
    notifyListeners();
  }

  /// Whether finished games should be auto-reset
  bool get autoReset => _autoReset;

  set autoReset(bool value) {
    if (value == null) return;

    if (value == _autoReset) return;

    _autoReset = value;

    _savePreference('autoReset', _autoReset);
    notifyListeners();
  }
}
