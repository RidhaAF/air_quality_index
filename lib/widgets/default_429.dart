import 'package:air_quality_index/widgets/default_404.dart';
import 'package:flutter/material.dart';

class Default429 extends StatelessWidget {
  const Default429({super.key});

  @override
  Widget build(BuildContext context) {
    return const Default404(
      image: 'assets/icons/ic_429.png',
      title: 'Too many requests',
      subtitle: 'Please try again later',
    );
  }
}
