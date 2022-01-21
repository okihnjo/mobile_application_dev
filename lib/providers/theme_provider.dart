import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:saloon_app/services/theme_service.dart';

// THEME PROVIDERS

// THEMES
// light
final _theme = ThemeData(
  primaryColor: Colors.deepPurple,
  bottomAppBarColor: Colors.black26,
  primaryColorDark: Colors.amber,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.deepPurple,
      shape: StadiumBorder(),
    ),
  ),
  textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headline2: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      )),
);

//dark
final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.deepPurple,
  primaryColorDark: Colors.blue,
  bottomAppBarColor: Colors.red,
  elevatedButtonTheme: _theme.elevatedButtonTheme,
  textTheme: _theme.textTheme.apply(
    displayColor: Colors.white,
    bodyColor: Colors.white,
  ),
);

final theme = Provider((ref) => _theme);
final darkTheme = Provider((ref) => _darkTheme);
final changeTheme = ChangeNotifierProvider.autoDispose((ref) {
  return ChangeThemeState();
});
