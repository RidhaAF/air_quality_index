import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/utilities/functions.dart';
import 'package:air_quality_index/widgets/default_app_bar.dart';
import 'package:air_quality_index/widgets/default_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _getData();
      setState(() {});
    }
  }

  _getData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Air Quality Index',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.my_location_rounded),
            tooltip: 'Find My Location',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
          ),
        ],
      ),
      body: DefaultRefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            SizedBox(height: defaultMargin),
            _locationInfo(),
            SizedBox(height: defaultMargin),
            _aqiWeatherInfo(),
          ],
        ),
      ),
    );
  }

  Widget _locationInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pin_drop_rounded,
            color: primaryColor,
          ),
          SizedBox(width: defaultMargin / 2),
          Text(
            'Bandung, Indonesia',
            style: GoogleFonts.dmSans(
              fontSize: 24,
              fontWeight: semiBold,
            ),
            textScaleFactor: 1.0,
          ),
        ],
      ),
    );
  }

  Widget _aqiWeatherInfo() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [primaryBoxShadow],
      ),
      child: Column(
        children: [
          _aqiInfo(),
          _weatherInfo(),
        ],
      ),
    );
  }

  Widget _aqiInfo() {
    int aqi = 5;
    String aqiStatus = aqiStatusFormatter(aqi);
    Color aqiColor = aqiColorFormatter(aqi);
    Color textColor = aqiTextColorFormatter(aqi);

    return Container(
      width: double.infinity,
      height: 96,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: defaultMargin / 2,
      ),
      decoration: BoxDecoration(
        color: aqiColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultRadius),
          topRight: Radius.circular(defaultRadius),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _usAqi(
                aqi: aqi,
                textColor: textColor,
              ),
              _aqiStatusPM(
                aqiStatus: aqiStatus,
                pm2point5: 43.6,
                textColor: textColor,
              ),
              _aqiGuide(
                textColor: textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _usAqi({required int aqi, required Color textColor}) {
    return Column(
      children: [
        Text(
          aqi.toString(),
          style: GoogleFonts.dmSans(
            color: textColor,
            fontSize: 40,
            fontWeight: bold,
          ),
          textScaleFactor: 1.0,
        ),
        Text(
          'US AQI',
          style: GoogleFonts.dmSans(
            color: textColor,
            fontSize: 12,
          ),
          textScaleFactor: 1.0,
        ),
      ],
    );
  }

  Widget _aqiStatusPM({
    required String aqiStatus,
    required double pm2point5,
    required Color textColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          _aqiStatus(
            aqiStatus: aqiStatus,
            textColor: textColor,
          ),
          SizedBox(height: defaultMargin / 2),
          _pm2point5(
            pm2point5: 43.6,
            textColor: textColor,
          ),
        ],
      ),
    );
  }

  Widget _aqiStatus({required String aqiStatus, required Color textColor}) {
    return Text(
      aqiStatus,
      style: GoogleFonts.dmSans(
        color: textColor,
        fontSize: 16,
        fontWeight: semiBold,
      ),
      textAlign: TextAlign.center,
      textScaleFactor: 1.0,
    );
  }

  Widget _pm2point5({required double pm2point5, required Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin / 2,
        vertical: defaultMargin / 8,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Text(
        'PM2.5 ${pm2point5.toString()} µg/m\u00b3',
        style: GoogleFonts.dmSans(
          color: textColor,
          fontSize: 14,
        ),
        textScaleFactor: 1.0,
      ),
    );
  }

  Widget _aqiGuide({required Color textColor}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.info_outline_rounded,
        size: 24,
        color: textColor,
      ),
      tooltip: 'AQI Guide',
    );
  }

  Widget _weatherInfo() {
    return Container(
      width: double.infinity,
      height: 64,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      padding: EdgeInsets.all(defaultMargin / 2),
      decoration: BoxDecoration(
        color: isDarkMode(context) ? bgColorDark4 : bgColorLight2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(defaultRadius),
          bottomRight: Radius.circular(defaultRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _weatherText(
            '30°C',
            icon: Icons.cloud_rounded,
            iconColor: greyColor,
          ),
          SizedBox(width: defaultMargin / 2),
          _weatherText(
            '6.4 km/h',
            icon: Icons.air_rounded,
            iconColor: Colors.lightBlue.shade100,
          ),
          SizedBox(width: defaultMargin / 2),
          _weatherText(
            '48%',
            icon: Icons.water_drop_rounded,
            iconColor: Colors.lightBlue.shade300,
          ),
        ],
      ),
    );
  }

  Widget _weatherText(
    text, {
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: defaultMargin / 2),
        Text(
          text,
          style: GoogleFonts.dmSans(),
          textScaleFactor: 1.0,
        ),
      ],
    );
  }
}
