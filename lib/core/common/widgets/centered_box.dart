import 'package:flutter/material.dart';

class CenteredBox extends StatelessWidget {
  const CenteredBox({required this.child, super.key, this.width, this.height, this.padding});

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }
}
