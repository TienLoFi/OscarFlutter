import 'dart:ui' as ui show TextHeightBehavior;
import 'package:oscar_ballot/consts.dart';
import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  const BorderedText({
    this.text = '',
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap = false,
    this.overflow,
    this.textScaleFactor,
    this.maxLines = 0,
    this.semanticsLabel = '',
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super();

  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Consts.textGreyColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(13.0),
      child: Text(
        text,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      ),
    );
  }
}
