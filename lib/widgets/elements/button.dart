import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/commons/custom_icons.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.width = 0,
    this.height = 40,
    this.radius,
    this.action,
    this.title = '',
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
    this.color = Colors.white,
    this.bgColor = Consts.primaryColor,
    this.borderColor = Consts.primaryColor,
    this.icon,
    this.titleStyle = Consts.buttonTitleStyle,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? radius;
  final Color color;
  final Color bgColor;
  final Color borderColor;
  final dynamic action;
  final IconData? icon;
  final String title;
  final TextStyle titleStyle;

  Button.facebook({
    Key? key,
    this.width = 50.0,
    @required this.action,
    this.margin = const EdgeInsets.all(8.0),
  })  : height = width,
        title = '',
        icon = CustomIcons.facebook,
        color = Colors.white,
        bgColor = Consts.facebookColor,
        borderColor = Consts.facebookColor,
        titleStyle = Consts.buttonTitleStyle,
        padding = const EdgeInsets.all(8.0),
        radius = BorderRadius.circular(25.0);

  Button.twitter({
    Key? key,
    this.width = 50.0,
    @required this.action,
    this.margin = const EdgeInsets.all(8.0),
  })  : height = width,
        title = '',
        icon = CustomIcons.twitter,
        color = Colors.white,
        bgColor = Consts.twitterColor,
        borderColor = Consts.twitterColor,
        titleStyle = Consts.buttonTitleStyle,
        padding = const EdgeInsets.all(8.0),
        radius = BorderRadius.circular(25.0);

  Button.apple({
    Key? key,
    this.width = 50.0,
    @required this.action,
    this.margin = const EdgeInsets.all(8.0),
  })  : height = width,
        title = '',
        icon = CustomIcons.apple,
        color = Colors.white,
        bgColor = Consts.darkColor,
        borderColor = Consts.darkColor,
        titleStyle = Consts.buttonTitleStyle,
        padding = const EdgeInsets.all(8.0),
        radius = BorderRadius.circular(25.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: radius ?? BorderRadius.circular(height / 2),
      ),
      child: Material(
        color: bgColor,
        borderOnForeground: true,
        type: MaterialType.button,
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        borderRadius: radius ?? BorderRadius.circular(height / 2),
        child: InkWell(
          onTap: action,
          splashColor: color.withOpacity(0.25),
          highlightColor: const Color(0x33FFFFFF),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      icon,
                      color: color,
                    ),
                  ),
                if (title.isNotEmpty)
                  Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: titleStyle.copyWith(color: color),
                  ),
              ],
            ),
          ),
        ),
       
      ),
    );
  }
}
