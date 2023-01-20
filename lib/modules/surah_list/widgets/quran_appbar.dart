import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/app_colors.dart';
import 'package:quran_app/common/constants/text_styles.dart';
import 'package:quran_app/modules/home/widgets/input_box.dart';

class QuranAppBar extends StatefulWidget implements PreferredSizeWidget {
  const QuranAppBar({
    super.key,
    required this.title,
    this.subtitle = '',
    this.showBack = true,
    this.onSearchChanged,
    required this.height,
    this.withSearch = false,
    this.content,
  });
  final String title;
  final String? subtitle;
  final bool showBack;
  final void Function(String)? onSearchChanged;
  final double height;
  final bool withSearch;
  final Widget? content;

  @override
  State<QuranAppBar> createState() => _QuranAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(height);
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
            widget.title,
            style: AppTextStyle().lightBoldTitle,
          ),
          backgroundColor: AppColors().backgroundColor2,
          leading: widget.showBack
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_rounded),
                )
              : null,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(widget.height),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.subtitle == '') ...[
                        const SizedBox()
                      ] else ...[
                        Text(
                          widget.subtitle!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors().backgroundColor,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                      if (widget.withSearch) ...[
                        InputBox(
                          labelText: 'Cari Surah',
                          onChanged: widget.onSearchChanged,
                        ),
                      ],
                      if (widget.content != null) ...[
                        widget.content ?? const SizedBox()
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
