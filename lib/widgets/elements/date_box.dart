import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/widgets/elements/rounded_rect.dart';
import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  DateBox({
    @required this.color,
    @required this.date,
    this.hasShadow = false,
  }) : super();

  final Color? color;
  final DateTime? date;
  final bool hasShadow;

  static const _monthName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  Widget build(BuildContext context) {
    return RoundedRect(
      color: Colors.white,
      width: 42.0,
      height: 42.0,
      hasShadow: hasShadow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _monthName[date!.month - 1],
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              color: Consts.darkColor,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            date!.day.toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: color,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
