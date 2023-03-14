import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTheme {
  static const Color _primaryColor = Color(0xFF22FFCA);
  static final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32),
    borderSide: const BorderSide(width: 2, color: _primaryColor),
  );

  static get(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      useMaterial3: true,
      primaryColor: _primaryColor,
      brightness: Brightness.dark,
      dividerTheme: const DividerThemeData(
        color: _primaryColor,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF171612),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: _primaryColor,
          ),
        ),
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: _primaryColor,
            displayColor: _primaryColor,
          ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(_primaryColor),
          
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: _primaryColor,
        outlineBorder: const BorderSide(color: _primaryColor),
        enabledBorder: _outlineInputBorder,
        border: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        background: const Color(0xFF1D1C17),
      ),
    );
  }
}
