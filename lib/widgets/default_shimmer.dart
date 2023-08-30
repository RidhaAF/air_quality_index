import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

Widget homeShimmer() {
  return Column(
    children: [
      SizedBox(height: defaultMargin),
      verticalShimmer(
        height: 32,
      ),
      SizedBox(height: defaultMargin),
      verticalShimmer(
        width: double.infinity,
        height: 160,
      ),
      SizedBox(height: defaultMargin),
      verticalShimmer(
        width: 128,
      ),
    ],
  );
}

Widget verticalShimmer({double? width, double? height}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
    child: ShimmerBox(
      width: width ?? 256,
      height: height ?? 16,
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
  );
}
