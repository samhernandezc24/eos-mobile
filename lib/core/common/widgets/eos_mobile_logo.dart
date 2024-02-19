import 'package:flutter/material.dart';

class EOSMobileLogo extends StatelessWidget {
  const EOSMobileLogo({super.key, this.width = 100});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo/eos_mobile_logo.png',
      fit: BoxFit.cover,
      width: width,
      filterQuality: FilterQuality.high,
    );
  }
}
