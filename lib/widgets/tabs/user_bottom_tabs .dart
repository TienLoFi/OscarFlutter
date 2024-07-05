// ignore_for_file: file_names
import 'package:oscar_ballot/commons/custom_icons.dart';
import 'package:flutter/material.dart';

class UserBottomTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            offset: Offset(0.0, 10.75),
            spreadRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavButton(
              icon: CustomIcons.ballot,
            ),
            _NavButton(
              icon: CustomIcons.group,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  _NavButton({
    this.icon,
    this.onTap,
  }) : super();

  final IconData? icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: Icon(
          icon
        ),
      ),
    );
  }
}
