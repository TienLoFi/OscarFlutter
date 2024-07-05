// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:oscar_ballot/config.dart';
import 'package:flutter/material.dart';

class Consts {
  static final apiUrl = Config().isReleaseMode
      ? 'http://192.168.1.214:8080'
      : 'https://oscarballot.sodaapp.online';
// 'http://backend.oscarballot.local:8080'
// 'http://192.168.1.214:8080'
  static const List<String> NOTIFICATION_TOPICS = [
    'system_messages',
  ];

  static const String HEADER_BACKGROUND_ASSET =
      "assets/images/png/header_background.png";
  static const String LARGE_LOGO_ASSET = "assets/images/svg/large_logo.svg";
  static const String DIALOG_BG_ASSET = "assets/images/svg/dialog_bg.svg";
  static const String NO_EVENT_PLACEHOLDER_ASSET =
      "assets/images/svg/fireworks.svg";
  static const String IMAGE_PLACEHOLDER_ASSET =
      "assets/images/png/img_placeholder.png";

  static const String TWITTER_CONSUMER_KEY = 'GjvJNTXAWx3JDwC9NyxWRRb3o';
  static const String TWITTER_CONSUMER_SCRET =
      '6kL46dVs7OUXajMyYLunpC2hG95XhrcPlX5LYgoaNHJ2U2JhZT';
  static const String FONT_SF_PRO = "SF Pro Display";
  static const String FONT_AMARANTH = "Amaranth";
  static const String FONT_AVENIR_NEXT = "AvenirNext";

  static final BEGIN_OF_TIME = DateTime.fromMillisecondsSinceEpoch(0);
  static final END_OF_TIME = DateTime.utc(3000, 1, 1);

  static const Color primaryColor = Color(0xFFCAA84A);
  static const Color primaryColorLight = Color(0xFFEBB92E);
  static const Color accentColor = Color(0xFFFFE52D);
  static const Color accentColorLight = Color(0xFFFEEEDC);
  static const Color greyColor = Color(0xFF979797);
  static const Color greenColor = Color(0xFF38C49A);
  static const Color dividerColor = Color(0xFFEBEBEB);
  static const Color lightGreyColor = Color(0xFFF6F6F6);
  static const Color darkColor = Color(0xFF323643);
  static const Color textGreyColor = Color(0xFFA8AFB8);
  static const Color facebookColor = Color(0xFF3B5998);
  static const Color twitterColor = Color(0xFF55ACEE);

  static const buttonTitleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    height: 1.2,
  );

  static const dropdownTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    color: Consts.darkColor,
  );

  static const List<Color> ITEM_COLORS = [
    Color(0xFF4A4AA3),
    Color(0xFF38B4C4),
    Color(0xFFF78202),
  ];

  static const List<Color> ITEM_BG_COLORS = [
    Color(0xFFE7E9FA),
    Color(0xFFE5F7F8),
    Color(0xFFFCF0E4),
  ];
}
