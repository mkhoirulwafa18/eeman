import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    required this.height,
    this.content,
  });

  final String title;
  final bool showBack;
  final double height;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 5,
          centerTitle: true,
          title: Text(
            title,
            style: lightBoldTitle,
          ),
          backgroundColor: backgroundColor2,
          leading: showBack
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_rounded),
                )
              : null,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: (content != null) ? content : const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
