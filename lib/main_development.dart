import 'package:flutter/material.dart';
import 'package:quran_app/app/app.dart';
import 'package:quran_app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
