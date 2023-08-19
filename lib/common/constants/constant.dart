import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/l10n/l10n.dart';

String get baseUrl => 'http://api.aladhan.com/v1/calendarByCity';
String get baseAudioUrl => 'https://everyayah.com/data/Alafasy_128kbps';
String get randomSurah => 'noRandomSurah';
String get randomAyat => 'noRandomAyat';
String get lastHitAotd => 'lastHitAotd';
List<String> get shalats => [
      'Akhir Sepertiga Malam',
      'Imsak',
      'Subuh',
      'Matahari Terbit',
      'Dzuhur',
      'Ashar',
      'Matahari Terbenam',
      'Maghrib',
      'Isha',
      'Tengah Malam',
      'Awal Sepertiga Malam',
    ];
int get cacheDays => 31;

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

/// ----------------
/// Show Dialog
/// ----------------
void showMyDialog(BuildContext context, String title, String content) {
  final l10n = context.l10n;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor2,
        title: Text(
          title,
          style: lightBoldTitle,
        ),
        content: Text(
          content,
          style: mediumText,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              l10n.close,
              style: smallText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

/// ----------------
/// Show Dialog
/// in HomePage which showing appInfo and request feature or send feedback func
/// ----------------
void showInfoDialog(BuildContext context, String title, String content) {
  final l10n = context.l10n;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor2,
        title: Text(
          title,
          style: lightBoldTitle,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              style: smallText,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              l10n.feedbackInfo,
              style: smallText,
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(
              l10n.feedbackAndReport,
              style: smallText,
            ),
            onPressed: () {
              // Navigator.push<MaterialPageRoute<dynamic>>(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const ReportFeedbackPage(),
              //       ),
              //     );
              Navigator.pop(context);
              BetterFeedback.of(context).show((feedback) async {
                // draft an email and send to developer
                final screenshotFilePath =
                    await writeImageToStorage(feedback.screenshot);
                final email = Email(
                  body: feedback.text,
                  subject: 'Eeman App Feedback',
                  recipients: ['wafastarzteam@gmail.com'],
                  attachmentPaths: [screenshotFilePath],
                );
                await FlutterEmailSender.send(email);
              });
            },
          ),
          TextButton(
            child: Text(
              l10n.close,
              style: smallText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
