import 'package:flutter/material.dart';

class OdoSajuColors {
  static const black01 = Color(0xff333333);
  static const greyBlue = Color(0xff688195);
  static const brownGrey02 = Color(0xff808080);
  static const iceBlue = Color(0xfff3f5f6);
  static const iceBlueDarker = Color(0xffeff1f3);
  static const greyishBrown = Color(0xff4d4d4d);
  static const white = Color(0xffffffff);
  static const lightBlueGrey = Color(0xffcfd3d5);
  static const lightBlueGreyDarker = Color(0xffc4d1db);
  static const rosa = Color(0xffff94a4);
  static const powderBlue = Color(0xffd2dbe1);
  static const rosyPink = Color(0xfff96b93);
  static const veryLightPink = Color(0xffcfcfcf);
  static const blueGrey = Color(0xff7f8e9b);
  static const blueGrey0 = Color(0x007f8e9b);
  static const lightPink = Color(0xffffe6ed);
  static const brownishGrey = Color(0xff666666);
  static const veryLightBlue = Color(0xffe5e8eb);
  static const eggShell = Color(0xffffe9c3);
  static const palePink = Color(0xffffccdc);
  static const paleSalmon = Color(0xfffec591);
  static const pastelBlue = Color(0xff9fbdfc);
  static const peachyPink = Color(0xffff8e8e);
  static const seafoamGreen = Color(0xff86e7a3);
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
