import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/commons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDialog extends StatelessWidget {
  AppDialog({
    Key? key,
    this.icon = CustomIcons.exclamation,
    this.title = '',
    this.content = '',
    this.actions,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final String content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width - 50.0;
    final height = width * 155.0 / 323.0 + 1.0;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  Consts.DIALOG_BG_ASSET,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
                Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 110.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 4.0),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: Consts.FONT_AMARANTH,
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions!,
            ),
          ),
        ],
      ),
    );
  }
}
