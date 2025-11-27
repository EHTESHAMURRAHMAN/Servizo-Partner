import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData.light().copyWith();
  static final dark = ThemeData.dark().copyWith();
}

ThemeData lightTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF148484),
    brightness: Brightness.light,
  ),
  primaryColor: const Color(0xFF148484),
  primaryColorDark: const Color(0xFF148484),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(backgroundColor: const Color(0xFF148484)),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffF8FAFB),
  canvasColor: const Color(0xffF1F1F1),
  cardTheme: CardTheme(color: const Color(0xffF1F1F1)),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith(
      (states) => const Color(0xFF148484),
    ),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xffF8FAFB),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,

      systemNavigationBarColor: Color(0xffF8FAFB),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Color(0xffF8FAFB),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.red,
    selectedItemColor: Color(0xff008EF9),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: const Color(0xffF1F1F1),
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);

ThemeData darkTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffFFB700),
    brightness: Brightness.dark,
  ),
  primaryColor: const Color(0xFF148484),
  primaryColorDark: const Color(0xffFFB700),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(backgroundColor: const Color(0xffFFB700)),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff171d29)),
  scaffoldBackgroundColor: const Color(0xff1B1B1B),
  canvasColor: const Color(0xff242426),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith(
      (states) => const Color(0xffFFB700),
    ),
  ),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1B1B1B),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff1B1B1B),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xff1B1B1B),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: const Color(0xff29313c),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xff04b98c),
    textTheme: ButtonTextTheme.primary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xffFFB700),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(20.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(20.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
);
