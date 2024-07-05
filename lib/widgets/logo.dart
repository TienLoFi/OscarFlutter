import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    this.color,
    this.width = 0,
  });

  final Color? color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/svg/logo.svg',
      width: width,
      // ignore: deprecated_member_use
      color: color,
      fit: BoxFit.contain,
    );
  }
}
