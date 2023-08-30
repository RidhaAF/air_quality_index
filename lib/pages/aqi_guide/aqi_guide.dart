import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/utilities/functions.dart';
import 'package:air_quality_index/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AqiGuide extends StatelessWidget {
  const AqiGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'AQI Guide',
      ),
      body: ListView(
        children: [
          _aqiDefinition(context),
          _aqiExample(context),
        ],
      ),
    );
  }

  Widget _aqiDefinition(context) {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      color: isDarkMode(context) ? bgColorDark4 : bgColorLight2,
      child: Text(
        'AQI, or Air Quality Index, is a system for reporting the severity of air quality levels in relatable terms to the public. The index ranges from 0 to 500, where high index values indicate higher levels of air pollution and higher potential for adverse health effects. Any value larger than 300, for example, is considered to',
        style: GoogleFonts.dmSans(),
        textScaleFactor: 1.0,
      ),
    );
  }

  Widget _aqiExample(context) {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      color: isDarkMode(context) ? bgColorDark4 : bgColorLight2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _aqiTile(
            aqiColor: greenColor,
            aqiStatus: '0 - 50 Good',
            aqiDescription:
                'Air quality is satisfactory and poses little or no risk. Ventilating your home is recommended.',
          ),
          SizedBox(height: defaultMargin * 2),
          _aqiTile(
            aqiColor: yellowColor,
            aqiStatus: '51 - 100 Moderate',
            aqiDescription:
                'Sensitive individuals should avoid outdoor activity as they may experience respiratory symptoms.',
          ),
          SizedBox(height: defaultMargin * 2),
          _aqiTile(
            aqiColor: orangeColor,
            aqiStatus: '101 - 150 Unhealthy for sensitive groups',
            aqiDescription:
                'General public and sensitive individuals in particular are at risk to experience irritation and respiratory problems.',
          ),
          SizedBox(height: defaultMargin * 2),
          _aqiTile(
            aqiColor: redColor,
            aqiStatus: '151 - 200 Unhealthy',
            aqiDescription:
                'Increased likelihood of adverse effects and aggravation to the heart and lungs among general public - particularly for sensitive groups.',
          ),
          SizedBox(height: defaultMargin * 2),
          _aqiTile(
            aqiColor: purpleColor,
            aqiStatus: '201 - 300 Very Unhealthy',
            aqiDescription:
                'General public will be noticeably affected. Sensitive groups will experience reduced endurance in activities. These individuals should remain indoors and restrict activities.',
          ),
          SizedBox(height: defaultMargin * 2),
          _aqiTile(
            aqiColor: brownColor,
            aqiStatus: '301 - 500 Hazardous',
            aqiDescription:
                'General public and sensitive groups are at high risk to experience strong irritations and adverse health effects that could trigger other illnesses. Everyone should avoid exercise and remain indoors.',
          ),
        ],
      ),
    );
  }

  Widget _aqiTile({
    required Color aqiColor,
    required String aqiStatus,
    required String aqiDescription,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: aqiColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        SizedBox(width: defaultMargin),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aqiStatus,
                style: GoogleFonts.dmSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.0,
              ),
              Text(
                aqiDescription,
                style: GoogleFonts.dmSans(
                  color: mutedColor,
                ),
                textScaleFactor: 1.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
