import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/constant.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    this.onChanged,
    this.labelText,
    this.enabled = true,
    this.autofocus = false,
    this.formatter,
    this.keyboardType,
    this.maxLength,
    this.controller,
  });
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final bool enabled;
  final bool autofocus;
  final List<TextInputFormatter>? formatter;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor2,
        border: Border.all(color: backgroundColor, width: 4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        enabled: enabled,
        cursorColor: backgroundColor,
        controller: controller,
        onChanged: onChanged,
        style: inputText,
        autofocus: autofocus,
        inputFormatters: formatter,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: inputLabel,
          floatingLabelStyle: inputLabel.copyWith(height: 1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
