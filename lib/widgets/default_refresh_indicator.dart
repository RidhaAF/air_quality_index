import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/utilities/functions.dart';
import 'package:flutter/material.dart';

class DefaultRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  const DefaultRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      color: primaryColor,
      backgroundColor: getContainerColor(context),
      child: child,
    );
  }
}
