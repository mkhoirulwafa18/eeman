import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  final String randomSurah = 'noRandomSurah';
  final String randomAyat = 'noRandomAyat';
  final String lastHitAotd = 'lastHitAotd';
  final shalats = [
    'Subuh',
    'Matahari Terbit',
    'Dzuhur',
    'Ashar',
    'Matahari Terbenam',
    'Maghrib',
    'Isha',
    'Imsak',
    'Tengah Malam',
    'Awal Sepertiga Malam',
    'Akhir Sepertiga Malam',
  ];
}

/// --------------
/// Constant Color
/// --------------

Color get backgroundColor => const Color(0xffF8EDDD);
Color get backgroundColor2 => const Color(0xff234D60);
Color get backgroundColorAlter => const Color(0xffF6E8D4);

Color get cardGreyColor => const Color(0xff788E99);
Color get cardPeachColor => const Color(0xffEA896C);
Color get cardGreenColor => const Color(0xff00CABC);
Color get cardYellowColor => const Color(0xffF0A97E);

/// --------------
/// Asset Location
/// --------------
/// Example: ${iconAsset}/logo.svg
String iconAsset = 'assets/icons';
String sourcesAsset = 'assets/sources';

/// ------------
/// Device Size
/// ------------
double get deviceWidth => ScreenUtil().screenWidth;
double get deviceHeight => ScreenUtil().screenHeight;

///  ------------
/// Device OS
/// ------------
String? get getDeviceOS => Platform.isAndroid
    ? 'android'
    : Platform.isIOS
        ? 'ios'
        : null;

MaterialColor primaryCustomSwatch = MaterialColor(0xffF8EDDD, {
  50: backgroundColor,
  100: backgroundColor,
  200: backgroundColor,
  300: backgroundColor,
  400: backgroundColor,
  500: backgroundColor,
  600: backgroundColor,
  700: backgroundColor,
  800: backgroundColor,
  900: backgroundColor,
});

MaterialColor primaryCustomSwatchDark = MaterialColor(0xff234D60, {
  50: backgroundColor2,
  100: backgroundColor2,
  200: backgroundColor2,
  300: backgroundColor2,
  400: backgroundColor2,
  500: backgroundColor2,
  600: backgroundColor2,
  700: backgroundColor2,
  800: backgroundColor2,
  900: backgroundColor2,
});

/// ----------------
/// Status Bar Color
/// ----------------
void setStatusBar({
  Brightness brightness = Brightness.dark,
  Color color = Colors.transparent,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    ),
  );
}

/// -----------------------------------
/// Font and size scaling screen utils
/// -----------------------------------
/// Initialize screen util and set default size
/// by device size
void setupScreenUtil(BuildContext context) {
  final baseWidth = MediaQuery.of(context).size.width;
  final baseHeight = MediaQuery.of(context).size.height;
  const defaultScreenUtilWidth = 1080;
  const defaultScreenUtilHeight = 1920;
  const iPadPro12InchWidth = 2048;
  const iPadPro12InchHeight = 2732;
  var designWidth = 0;
  var designHeight = 0;

  /// ipad 11-inch width: 834, height: 1194
  /// ipad 9-inch width: 768, height: 1024
  if (baseWidth >= 768) {
    designWidth = iPadPro12InchWidth;
  } else {
    designWidth = defaultScreenUtilWidth;
  }

  if (baseHeight >= 1024) {
    designHeight = iPadPro12InchHeight;
  } else {
    designHeight = defaultScreenUtilHeight;
  }

  ScreenUtil.init(
    context,
    designSize: Size(designWidth.toDouble(), designHeight.toDouble()),
  );
}

bool isSmallPhoneHeight(BuildContext context) =>
    MediaQuery.of(context).size.height < 700;
bool isReallySmallPhoneHeight(BuildContext context) =>
    MediaQuery.of(context).size.height < 600;
bool isBigPhoneHeight(BuildContext context) =>
    MediaQuery.of(context).size.height > 1200;

/// Setting height and width
double setWidth(double width) => ScreenUtil().setWidth(width);
double setHeight(double height) => ScreenUtil().setHeight(height);

/// -----------------------------------
/// Constant Base Text Styling
/// -----------------------------------

TextStyle inputLabel = TextStyle(
  color: backgroundColor.withOpacity(0.7),
  fontFamily: 'Poppins',
  fontSize: 14,
);

TextStyle inputText = TextStyle(
  color: backgroundColor,
  fontFamily: 'Poppins',
  fontSize: 16,
);

TextStyle lightBoldTitle = TextStyle(
  color: backgroundColor,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 32,
);

TextStyle smallText = TextStyle(
  color: backgroundColor,
  fontFamily: 'Poppins',
  fontSize: 12,
);
TextStyle mediumText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  color: backgroundColor,
);
TextStyle largeText = TextStyle(
  color: backgroundColor,
  fontFamily: 'Poppins',
  fontSize: 24,
);

TextStyle arabicText = TextStyle(
  fontFamily: 'IsepMisbah',
  fontSize: 24,
  color: backgroundColor2,
  height: 2,
);

/// -----------------------------------
/// Constant Base Text Styling
/// -----------------------------------

BoxShadow primaryShadow = BoxShadow(
  color: Colors.black.withOpacity(0.5),
  blurRadius: 4,
  offset: const Offset(0, 4),
);
