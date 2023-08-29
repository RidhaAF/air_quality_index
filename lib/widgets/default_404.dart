import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';

class Default404 extends StatelessWidget {
  const Default404({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic_404.png',
              width: 96,
            ),
            SizedBox(height: defaultMargin * 2),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: primaryColor,
                    fontWeight: bold,
                  ),
              textScaleFactor: 1.0,
            ),
            SizedBox(height: defaultMargin / 4),
            Text(
              'Data not found',
              style: Theme.of(context).textTheme.titleSmall,
              textScaleFactor: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
