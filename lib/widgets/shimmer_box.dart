import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/utilities/functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: borderRadius == null
          ? _shimmer(context)
          : ClipRRect(
              borderRadius: borderRadius,
              child: _shimmer(context),
            ),
    );
  }

  Widget _shimmer(context) {
    return Shimmer.fromColors(
      baseColor: getContainerColor(context),
      highlightColor: isDarkMode(context) ? greyColor : secondaryColor,
      child: Container(
        color: mutedColor,
      ),
    );
  }
}
