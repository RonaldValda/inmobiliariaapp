import 'package:flutter/material.dart';

class ColorsDefault{
  static bool isDark=false;
  //static Color get colorPrimary => isDark?Colors.white:Color.fromRGBO(15, 92, 8, 0.3);
  static Color get colorPrimary => isDark?Colors.white:Color.fromRGBO(132, 192, 198, 1);
  //static Color get colorBackgroud => isDark?Colors.black:Color.fromRGBO(64, 64, 64, 1);
  static Color get colorBackgroud => isDark?Colors.black:Color.fromRGBO(255, 255, 255, 1);
  static Color get colorBackgroundBarrier => isDark?Colors.black:Color.fromRGBO(0, 0, 0, 0.3);
  static Color get colorText => isDark?Colors.white:Color.fromRGBO(40, 40, 40, 1);
  static Color get colorTextLabel => isDark?Colors.white:Color.fromRGBO(64, 64, 64, 1);
  static Color get colorTextError => isDark?Colors.white:Color.fromRGBO(236, 12, 12, 1);
  static Color get colorSelectedTab => isDark?Colors.white:Color.fromRGBO(132, 192, 198, 0.3);
  static Color get colorTextInfo => isDark?Colors.white:Color.fromRGBO(136, 136, 136, 1);
  static Color get colorTextFieldBackground => isDark?Colors.white:Color.fromRGBO(255,255, 255, 1);
  static Color get colorSplashListTile => isDark?Colors.white:Color.fromRGBO(132, 192, 198, 0.3);
  static Color get colorBorder => isDark?Colors.white:Color.fromRGBO(150, 150, 150, 1);
  static Color get colorBorderDisabled => isDark?Colors.white:Color.fromRGBO(220, 220, 220, 1);
  static Color get colorFontHintTextField => isDark?Colors.white:Color.fromRGBO(80, 80, 80, 1);
  static Color get colorSeparatedDropDownItem => isDark?Colors.white:Color.fromRGBO(132, 192, 198, 0.2);
  static Color get colorIcon => isDark?Colors.white:Color.fromRGBO(64, 64, 64, 1);
  static Color get colorIconBackgroundAppBar  => isDark?Colors.white:Color.fromRGBO(132, 192, 198, 0.3);
  static Color get colorBorderBottomDropDownAppBar => isDark?Colors.white:Color.fromRGBO(216, 216, 216, 1);
  static Color get colorButtonAddImage => isDark?Colors.white:Color.fromRGBO(236, 236, 236, 1);
  static Color get colorShadowCardImage => isDark?Colors.white:Color.fromRGBO(0, 0, 0, 0.1);
  static Color get colorTextApproved => isDark?Colors.white:Color.fromRGBO(36, 142, 9, 1);
  static Color get colorTextRefused => isDark?Colors.white:Color.fromRGBO(216, 35, 35, 1);
  static Color get colorTextPending => isDark?Colors.white:Color.fromRGBO(11, 123, 222, 1);
  static Color get colorBackgroundRequestStatus => isDark?Colors.white:Color.fromRGBO(236, 236, 236, 1);
  static Color get colorTabItemTransparent => isDark?Colors.white:Color.fromRGBO(0, 0, 0, 0.3);
  static Color get colorSeparated => isDark?Colors.white:Color.fromRGBO(222, 222, 222, 1);
  static Color get colorBackgroundSelectedListTile => isDark?Colors.white:Color.fromRGBO(132, 192, 198, .2);
  static Color get colorTextListTileTitle => isDark?Colors.white:Color.fromRGBO(40, 40, 40, 1);
  static Color get colorTextListTileSubtitle => isDark?Colors.white:Color.fromRGBO(80, 80, 80, 1);
  static Color get colorBackgroundListTileSelected => isDark?Colors.white:Color.fromRGBO(132, 192, 198, .3);
  static Color get colorFavorite => isDark?Colors.white:Color.fromRGBO(236, 12, 12, 1);
  static Color get colorButtonDisabled => isDark?Colors.white:Color.fromRGBO(236, 236, 236, 1);
  static Color get colorTextDisabled => isDark?Colors.white:Color.fromRGBO(210, 210, 210, 1);
  static Map<String,dynamic> get mapColorStatusRequests => {
    "Activo": isDark?Colors.white:Color.fromRGBO(132, 192, 198, 1),
    "Inactivo": isDark?Colors.white:Color.fromRGBO(236, 12, 12, 1),
    "Pendiente - Corregir datos": isDark?Colors.white:Color.fromRGBO(11, 123, 222, 1),
    "Pendiente":isDark?Colors.white:Color.fromRGBO(11, 123, 222, 1),
    "Pendiente - Publicar": isDark?Colors.white:Color.fromRGBO(11, 123, 222, 1),
    "Bloqueado": isDark?Colors.white:Color.fromRGBO(80, 80, 80, 1),
  };
}