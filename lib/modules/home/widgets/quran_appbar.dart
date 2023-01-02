import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuranAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

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
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color(0xff011240),
      leading: showBack
          ? GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
              child: const Icon(Icons.arrow_back),
            )
          : null,
      // actions: const [
      //   Padding(
      //     padding: EdgeInsets.all(16),
      //     child: Icon(
      //       Icons.search,
      //     ),
      //   ),
      // ],
    );
  }
}
