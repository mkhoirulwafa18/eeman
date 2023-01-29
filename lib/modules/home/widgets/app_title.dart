import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Eeman',
      style: lightBoldTitle,
    );
  }
}
