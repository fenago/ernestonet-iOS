import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_barrel.dart';

ThemeData appPrimaryTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      accentColor: Palette.appColor,
      scaffoldBackgroundColor: Colors.white,
      buttonColor: Palette.appColor,
      cardColor: Colors.white,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Palette.appColor,
        contentTextStyle: TextStyle(color: Colors.white),
        actionTextColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        elevation: 1.0,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      dividerColor: Colors.grey[300],
      dividerTheme: DividerThemeData(thickness: 0.3),
      tabBarTheme: TabBarTheme(
        labelColor: Palette.appColor,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 16.0,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 16.0,
        ),
      ),
      textTheme: TextTheme(
        headline3: GoogleFonts.montserrat(
          fontSize: 42.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline4: GoogleFonts.montserrat(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline5: GoogleFonts.montserrat(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        headline6: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        subtitle1: GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        subtitle2: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        bodyText1: GoogleFonts.montserrat(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodyText2: GoogleFonts.montserrat(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        button: GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );

ThemeData appDarkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900],
      accentColor: Palette.appColor,
      scaffoldBackgroundColor: Colors.grey[900],
      buttonColor: Palette.appColor,
      cardColor: Colors.grey[200],
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[800],
        contentTextStyle: TextStyle(color: Palette.appColor),
        actionTextColor: Palette.appColor,
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        elevation: 1.0,
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      dividerColor: Colors.grey[800],
      dividerTheme: DividerThemeData(thickness: 0.2),
      tabBarTheme: TabBarTheme(
        labelColor: Palette.appColor,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 16.0,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 16.0,
        ),
      ),
      textTheme: TextTheme(
        headline3: GoogleFonts.montserrat(
          fontSize: 42.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline4: GoogleFonts.montserrat(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline5: GoogleFonts.montserrat(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        headline6: GoogleFonts.montserrat(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        subtitle1: GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        subtitle2: GoogleFonts.montserrat(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyText1: GoogleFonts.montserrat(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodyText2: GoogleFonts.montserrat(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        button: GoogleFonts.montserrat(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
