import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Default404 extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  const Default404({
    super.key,
    this.image,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image ?? 'assets/icons/ic_404.png',
              width: 96,
            ),
            SizedBox(height: defaultMargin * 2),
            Text(
              title ?? 'Oops!',
              style: GoogleFonts.dmSans(
                color: primaryColor,
                fontSize: 28,
                fontWeight: bold,
              ),
              textScaleFactor: 1.0,
            ),
            SizedBox(height: defaultMargin / 4),
            Text(
              subtitle ?? 'Data not found',
              style: GoogleFonts.dmSans(
                color: mutedColor,
              ),
              textScaleFactor: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
