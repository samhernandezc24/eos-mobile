import 'package:eos_mobile/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class EOSLogo extends StatelessWidget {
  const EOSLogo({super.key, this.width = 100.0});

  final double width;

  @override
  Widget build(BuildContext context) => Image.asset(
    AppAssets.appLogo,
    fit: BoxFit.cover,
    width: width,
    filterQuality: FilterQuality.high,
  );
}
