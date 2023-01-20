import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/app_colors.dart';
import 'package:quran_app/common/constants/text_styles.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    this.onChanged,
    this.labelText,
    this.enabled = true,
  });
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors().backgroundColor2,
        border: Border.all(color: AppColors().backgroundColor, width: 4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        enabled: enabled,
        cursorColor: AppColors().backgroundColor,
        onChanged: onChanged,
        style: textStyle.inputText,
        decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: textStyle.inputLabel,
          floatingLabelStyle: textStyle.inputLabel.copyWith(height: 1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
