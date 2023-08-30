import 'package:air_quality_index/cubits/aqi/aqi_cubit.dart';
import 'package:air_quality_index/models/aqi_model.dart';
import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/utilities/functions.dart';
import 'package:air_quality_index/widgets/default_404.dart';
import 'package:air_quality_index/widgets/default_app_bar.dart';
import 'package:air_quality_index/widgets/default_refresh_indicator.dart';
import 'package:air_quality_index/widgets/default_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _getData();
      setState(() {});
    }
  }

  Future<void> _getUserLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      Geolocator.openLocationSettings().then((value) => _getUserLocation());
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Geolocator.openAppSettings().then((value) => _getUserLocation());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings().then((value) => _getUserLocation());
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;
  }

  _getData() {
    _getUserLocation().then((value) {
      context.read<AqiCubit>().getNearestCityAqi(
            latitude: latitude,
            longitude: longitude,
          );
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Air Quality Index',
        actions: [
          IconButton(
            onPressed: () {
              _getData();
              setState(() {});
            },
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
            BlocBuilder<AqiCubit, AqiState>(
              builder: (context, state) {
                if (state is AqiInitial) {
                  return Container();
                } else if (state is AqiLoading) {
                  return homeShimmer();
                } else if (state is AqiLoaded) {
                  AqiData? aqiData = state.aqiModel.data;

                  return Column(
                    children: [
                      SizedBox(height: defaultMargin),
                      _locationInfo(aqiData),
                      SizedBox(height: defaultMargin),
                      _aqiWeatherInfo(aqiData),
                      SizedBox(height: defaultMargin),
                      _lastUpdated(aqiData),
                    ],
                  );
                }
                return const Default404();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationInfo(AqiData? aqiData) {
    String city = aqiData?.city ?? '';
    String country = aqiData?.country ?? '';
    String location = '$city, $country';

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
            location,
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

  Widget _aqiWeatherInfo(AqiData? aqiData) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [primaryBoxShadow],
      ),
      child: Column(
        children: [
          _aqiInfo(aqiData),
          _weatherInfo(aqiData),
        ],
      ),
    );
  }

  Widget _aqiInfo(AqiData? aqiData) {
    int? aqi = aqiData?.current?.pollution?.aqius ?? 0;
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
                aqiData,
                aqiStatus: aqiStatus,
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

  Widget _aqiStatusPM(
    AqiData? aqiData, {
    required String aqiStatus,
    required Color textColor,
  }) {
    double? pm2point5 = aqiData?.current?.pollution?.aqicn?.toDouble() ?? 0.0;

    return Expanded(
      child: Column(
        children: [
          _aqiStatus(
            aqiStatus: aqiStatus,
            textColor: textColor,
          ),
          SizedBox(height: defaultMargin / 2),
          _pm2point5(
            pm2point5: pm2point5,
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
      onPressed: () {
        context.push('/aqi-guide');
      },
      icon: Icon(
        Icons.info_outline_rounded,
        size: 24,
        color: textColor,
      ),
      tooltip: 'AQI Guide',
    );
  }

  Widget _weatherInfo(AqiData? aqiData) {
    int? temperature = aqiData?.current?.weather?.tp ?? 0;
    double? windSpeed = aqiData?.current?.weather?.ws ?? 0;
    int? humidity = aqiData?.current?.weather?.hu ?? 0;
    String? icon = aqiData?.current?.weather?.ic ?? '03d';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _weatherText(
            '$temperature°C',
            icon: _weatherIcon(icon: icon),
          ),
          SizedBox(width: defaultMargin / 2),
          _weatherText(
            '$windSpeed km/h',
            icon: Icon(
              Icons.air_rounded,
              color: Colors.lightBlue.shade100,
            ),
          ),
          SizedBox(width: defaultMargin / 2),
          _weatherText(
            '$humidity%',
            icon: Icon(
              Icons.water_drop_rounded,
              color: Colors.lightBlue.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherIcon({required String icon}) {
    return Image.asset(
      'assets/icons/weather/$icon.png',
      width: 32,
      height: 32,
      fit: BoxFit.contain,
      semanticLabel: 'Weather Icon',
      errorBuilder: (context, error, stackTrace) => _weatherIcon(icon: '03d'),
    );
  }

  Widget _weatherText(
    text, {
    required Widget icon,
  }) {
    return Row(
      children: [
        icon,
        SizedBox(width: defaultMargin / 2),
        Text(
          text,
          style: GoogleFonts.dmSans(),
          textScaleFactor: 1.0,
        ),
      ],
    );
  }

  Widget _lastUpdated(AqiData? aqiData) {
    DateTime time = aqiData?.current?.pollution?.ts ??
        DateTime.parse('1970-01-01T00:00:00.000Z');
    String lastUpdated = timeLocalFormatter(time);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Text(
        'Last updated: $lastUpdated',
        style: GoogleFonts.dmSans(
          color: mutedColor,
          fontSize: 12,
          fontWeight: semiBold,
        ),
        textAlign: TextAlign.center,
        textScaleFactor: 1.0,
      ),
    );
  }
}
