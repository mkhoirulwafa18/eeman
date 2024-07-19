import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';

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
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.onSurface, width: 4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        enabled: enabled,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        controller: controller,
        onChanged: onChanged,
        style: context.bodyMedium,
        autofocus: autofocus,
        inputFormatters: formatter,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          floatingLabelStyle:
              context.bodySmall?.copyWith(height: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
