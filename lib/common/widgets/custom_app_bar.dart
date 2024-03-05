import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.height,
    this.content,
    this.actions,
    this.onBackTapped,
  });

  final String title;
  final bool showBack;
  final double? height;
  final Widget? content;
  final List<Widget>? actions;
  final void Function()? onBackTapped;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: backgroundColor2,
          ),
          elevation: 5,
          centerTitle: true,
          title: Text(
            title.replaceAll('\n', ' '),
            style: lightBoldTitle.copyWith(fontSize: 24),
          ),
          backgroundColor: backgroundColor2,
          leading: showBack
              ? GestureDetector(
                  onTap: onBackTapped ?? () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_rounded, color: backgroundColor),
                )
              : null,
          actions: actions,
          bottom: content != null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(height ?? kToolbarHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: content,
                  ),
                )
              : const PreferredSize(
                  preferredSize: Size.zero,
                  child: SizedBox(),
                ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
