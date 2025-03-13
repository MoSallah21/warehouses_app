import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme{
  static OutlineInputBorder _border({required Color color})=> OutlineInputBorder(
    borderSide:BorderSide(
        color: color,
        width: 3
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final dartThemeMode=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallat.backgroundColor,
    inputDecorationTheme:  InputDecorationTheme(
      contentPadding:  const EdgeInsets.all(27),
      enabledBorder: _border(color: Pallat.borderColor),
      focusedBorder: _border(color:Pallat.gradient2,)
    )
  );
  static final lightThemeMode=ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      hourMinuteTextColor: Colors.grey[800],
      dialTextColor: Colors.grey[800],
      dialBackgroundColor: Colors.grey[300],
      dayPeriodTextColor: WidgetStateColor.resolveWith((states) => Colors.grey[800]!),
      entryModeIconColor: Colors.grey[800],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.grey[800]),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.grey[800],
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.grey[800]!,
      primary: Colors.grey[800]!,
      secondary: Colors.grey[600]!,
      background: Colors.white,
      surface: Colors.grey[200]!,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
  );
}