import 'package:flutter/material.dart';

class RoundedRect extends StatelessWidget {
  const RoundedRect({
    Key? key,
    this.radius,
    this.width = 0,
    this.height = 0,
    this.child,
    this.color = Colors.transparent,
    this.hasShadow = false,
  }) : super(key: key);

  final BorderRadiusGeometry? radius;
  final double width;
  final double height;
  final Widget? child;
  final Color color;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    final borderRadius = radius ?? BorderRadius.circular(12.0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: [
          if (hasShadow)
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 0.2,
            )
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
