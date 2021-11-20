import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:game2048flutter/types/game_palette.dart';

/// The collection of colors used by this app
class Palette {
  Palette._();

  /// All [GamePalette]s available
  static const List<GamePalette> gamePalettes = [
    GamePalette.classic,
    GamePalette.dracula,
  ];

  /// Returns the [GamePalette] with the given name
  ///
  /// If no palette is found, returns null
  static GamePalette getGamePaletteByName(String name) {
    if (name == null) return null;

    final lowerCaseName = name.toLowerCase();

    for (final gamePalette in gamePalettes) {
      if (gamePalette.name.toLowerCase() == lowerCaseName) {
        return gamePalette;
      }
    }

    return null;
  }

  /// A [LinearGradient] of silver shades
  static const Gradient silverGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Colors.teal,
      Colors.deepPurple,
      Colors.orange,
      Colors.lightGreenAccent,
      Colors.green,
      Colors.blueAccent,
    ],
    stops: <double>[0, 0.20, 0.40, 0.60, 0.80, 1],
  );

  /// A [LinearGradient] of golden shades
  static const Gradient goldenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xffe7a220),
      Color(0xfffdcc33),
      Color(0xffffdf00),
      Color(0xfffdbf1c),
      Color(0xffc27d00),
      Color(0xff996515),
    ],
    stops: <double>[0, 0.20, 0.40, 0.60, 0.80, 1],
  );

  /// The [ColorScheme] used to build the [ThemeData] with light brightness
  static const ColorScheme lightTheme = ColorScheme(
    primary: Colors.amber,
    primaryVariant: Color(0xffd84315),
    secondary: Colors.yellow,
    secondaryVariant: Colors.blueAccent,
    surface: Colors.deepOrange,
    background: Colors.deepOrange,
    error: Colors.teal,
    onPrimary: Colors.lightGreen,
    onSecondary: Colors.orange,
    onSurface: Colors.yellow,
    onBackground: Colors.teal,
    onError: Colors.teal,
    brightness: Brightness.light,
  );

  /// The [ColorScheme] used to build the [ThemeData] with dark brightness
  static const ColorScheme darkTheme = ColorScheme(
    primary: Color(0xFF006064),
    primaryVariant: Color(0xffB0BEC5),
    secondary: Color(0xffEF5350),
    secondaryVariant: Color(0xff80413e),
    surface: Color(0xffFF5722),
    background: Color(0xff000000),
    error: Color(0xff550c18),
    onPrimary: Color(0xffe8e8e8),
    onSecondary: Color(0xffececec),
    onSurface: Color(0xffdadfe1),
    onBackground: Color(0xffdadfe1),
    onError: Color(0xffeeeeee),
    brightness: Brightness.dark,
  );
}
