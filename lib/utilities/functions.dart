import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isDarkMode(BuildContext context) {
  return AdaptiveTheme.of(context).brightness == Brightness.dark;
}

Color getContainerColor(BuildContext context) {
  return isDarkMode(context) ? bgColorDark1 : bgColorLight1;
}

String timeFormatter(DateTime dateTime) {
  return DateFormat.jm().format(dateTime);
}

String aqiStatusFormatter(int aqi) {
  String aqiStatus = 'Good';

  if (aqi <= 50) {
    aqiStatus = 'Good';
  } else if (aqi <= 100) {
    aqiStatus = 'Moderate';
  } else if (aqi <= 150) {
    aqiStatus = 'Unhealthy for sensitive groups';
  } else if (aqi <= 200) {
    aqiStatus = 'Unhealthy';
  } else if (aqi <= 300) {
    aqiStatus = 'Very unhealthy';
  } else {
    aqiStatus = 'Hazardous';
  }

  return aqiStatus;
}

Color aqiColorFormatter(int aqi) {
  Color aqiColor = primaryColor;

  if (aqi <= 50) {
    aqiColor = greenColor;
  } else if (aqi <= 100) {
    aqiColor = yellowColor;
  } else if (aqi <= 150) {
    aqiColor = orangeColor;
  } else if (aqi <= 200) {
    aqiColor = redColor;
  } else if (aqi <= 300) {
    aqiColor = purpleColor;
  } else {
    aqiColor = brownColor;
  }

  return aqiColor;
}

Color aqiTextColorFormatter(int aqi) {
  Color aqiTextColor = primaryColor;

  if (aqi <= 50) {
    aqiTextColor = darkGreenColor;
  } else if (aqi <= 100) {
    aqiTextColor = darkYellowColor;
  } else if (aqi <= 150) {
    aqiTextColor = darkOrangeColor;
  } else if (aqi <= 200) {
    aqiTextColor = darkRedColor;
  } else if (aqi <= 300) {
    aqiTextColor = darkPurpleColor;
  } else {
    aqiTextColor = darkBrownColor;
  }

  return aqiTextColor;
}
