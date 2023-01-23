import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class HomePageBackground extends StatelessWidget {
  const HomePageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding;
    final kBackgroundContainerHeight = MediaQuery.of(context).size.height / 3.5;
    return Column(
      children: [
        Container(
          color: backgroundColor2,
          height: kBackgroundContainerHeight + safeArea.top,
        ),
      ],
    );
  }
}
