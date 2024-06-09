import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';

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
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          ),
          elevation: 5,
          centerTitle: true,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            title.replaceAll('\n', ' '),
            style: context.displayLarge?.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.secondary),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: showBack
              ? GestureDetector(
                  onTap: onBackTapped ?? () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary),
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
