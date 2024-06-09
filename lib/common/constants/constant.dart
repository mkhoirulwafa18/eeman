import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

String get baseAudioUrl => 'https://everyayah.com/data/Alafasy_128kbps';

String get emailForReceivingEmailFeedback => 'wafastarzteam@gmail.com';

List<String> get shalats => [
      'Subuh',
      'Matahari Terbit',
      'Dzuhur',
      'Ashar',
      'Maghrib',
      'Isha',
    ];

/// ------------
/// Size
/// ------------
abstract class EemanSizes {
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s40 = 40;
  static const double s44 = 44;
  static const double s48 = 48;
  static const double s52 = 52;
  static const double s56 = 56;
  static const double s60 = 60;
  static const double s64 = 64;
  static const double s68 = 68;
  static const double s72 = 72;
  static const double s76 = 76;
  static const double s80 = 80;

  static const double heightButton = s52;
}

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

/// ----------------
/// Check Internet Connection
/// ----------------
Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

/// ----------------------------------
/// Write image to Storage for Info Dialog Feedback
/// ----------------------------------
/// to save screenshot to storage and then send to email app
Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
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

bool isSmallPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height < 700;
bool isReallySmallPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height < 600;
bool isBigPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height > 1200;

/// Setting height and width
double setWidth(double width) => ScreenUtil().setWidth(width);
double setHeight(double height) => ScreenUtil().setHeight(height);

/// -----------------------------------
/// Constant Base Text Styling
/// -----------------------------------

// TextStyle inputLabel = TextStyle(
//   color: backgroundColor.withOpacity(0.7),
//   fontFamily: 'Poppins',
//   fontSize: 14,
// );

// TextStyle inputText = TextStyle(
//   color: backgroundColor,
//   fontFamily: 'Poppins',
//   fontSize: 16,
// );

// TextStyle displayLarge = TextStyle(
//   color: backgroundColor,
//   fontFamily: 'Poppins',
//   fontWeight: FontWeight.w600,
//   fontSize: 32,
// );

// TextStyle context.bodySmall = TextStyle(
//   color: backgroundColor,
//   fontFamily: 'Poppins',
//   fontSize: 12,
// );

// TextStyle context.bodyMedium = TextStyle(
//   fontFamily: 'Poppins',
//   fontSize: 16,
//   color: backgroundColor,
// );

// TextStyle displayLarge = TextStyle(
//   color: backgroundColor,
//   fontFamily: 'Poppins',
//   fontSize: 24,
// );

/// -----------------------------------
/// Constant Base Text Styling
/// -----------------------------------

BoxShadow primaryShadow = BoxShadow(
  color: Colors.black.withOpacity(0.5),
  blurRadius: 4,
  offset: const Offset(0, 4),
);
