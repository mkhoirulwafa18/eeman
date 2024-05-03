import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    required this.title,
    required this.icon,
    required this.bgColor,
  });
  final String title;
  final Widget icon;
  final Color bgColor;
}
