import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuranAppBar extends StatefulWidget implements PreferredSizeWidget {
  const QuranAppBar({
    super.key,
    required this.appBar,
    required this.title,
    this.showBack = true,
  });
  final AppBar appBar;
  final String title;
  final bool showBack;

  @override
  State<QuranAppBar> createState() => _QuranAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _QuranAppBarState extends State<QuranAppBar> {
  bool isDarkModeEnabled = false;

  // ignore: avoid_positional_boolean_parameters
  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color(0xff011240),
      leading: widget.showBack
          ? GestureDetector(
              onTap: () =>
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
              child: const Icon(Icons.arrow_back),
            )
          : null,
      actions: [
        DayNightSwitcherIcon(
          isDarkModeEnabled: isDarkModeEnabled,
          onStateChanged: onStateChanged,
        ),
      ],
    );
  }
}
