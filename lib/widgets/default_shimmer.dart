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

Widget verticalShimmer({double? width, double? height, bool isPadding = true}) {
  return Container(
    padding: isPadding ? EdgeInsets.symmetric(horizontal: defaultMargin) : null,
    child: ShimmerBox(
      width: width ?? 256,
      height: height ?? 16,
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
  );
}

Widget listTileShimmer({int? itemCount}) {
  return ListView.separated(
    itemCount: itemCount ?? 20,
    separatorBuilder: (context, i) => const Divider(height: 0),
    itemBuilder: (context, i) {
      return ListTile(
        title: verticalShimmer(
          width: double.infinity,
          isPadding: false,
        ),
      );
    },
  );
}
