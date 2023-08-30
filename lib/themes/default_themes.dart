import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultThemes {
  ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgColorLight3,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bgColorLight2,
    ),
    fontFamily: GoogleFonts.dmSans().fontFamily,
    textTheme: TextTheme(
      titleSmall: GoogleFonts.dmSans(
        color: greyColor,
      ),
      labelMedium: GoogleFonts.dmSans(
        color: greyColor,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: bgColorLight2,
      foregroundColor: primaryColor,
      elevation: 0.0,
      titleTextStyle: GoogleFonts.dmSans(
        color: primaryColor,
        fontSize: bodyFS,
        fontWeight: semiBold,
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(
        primaryColor.withOpacity(0.1),
      ),
      shape: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRadius),
            ),
            side: BorderSide(color: primaryColor),
          );
        }
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultRadius),
          ),
          side: BorderSide.none,
        );
      }),
      hintStyle: MaterialStateProperty.all(
        GoogleFonts.dmSans(
          color: greyColor,
          fontSize: calloutFS,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.dmSans(
          fontSize: calloutFS,
        ),
      ),
    ),
  );

  ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColorDark3,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bgColorDark2,
    ),
    fontFamily: GoogleFonts.dmSans().fontFamily,
    textTheme: TextTheme(
      titleSmall: GoogleFonts.dmSans(
        color: mutedColor,
      ),
      labelMedium: GoogleFonts.dmSans(
        color: mutedColor,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: bgColorDark4,
      foregroundColor: primaryColor,
      elevation: 0.0,
      titleTextStyle: GoogleFonts.dmSans(
        color: primaryColor,
        fontSize: bodyFS,
        fontWeight: semiBold,
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(
        primaryColor.withOpacity(0.1),
      ),
      shape: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRadius),
            ),
            side: BorderSide(color: primaryColor),
          );
        }
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultRadius),
          ),
          side: BorderSide.none,
        );
      }),
      hintStyle: MaterialStateProperty.all(
        GoogleFonts.dmSans(
          color: mutedColor,
          fontSize: calloutFS,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.dmSans(
          fontSize: calloutFS,
        ),
      ),
    ),
  );
}
