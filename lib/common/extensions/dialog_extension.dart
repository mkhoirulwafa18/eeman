import 'package:flutter/material.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/l10n/l10n.dart';

/// [DialogExtension] used for easy showing dialog anywhere in the app.
///
/// how to use :
///
/// ```
/// context.showAppDialog(
///   title: context.l10n.internetNeeded,
///   content: Text(
///     context.l10n.internetNeededDesc,
///     style: context.bodyMedium,
///   ),
/// );
/// ```

extension DialogExtension on BuildContext {
/// Displays a custom application dialog with the given title, content, and action button.
///
/// The dialog will use the primary color from the current theme for its background
/// and the secondary color for the text styles.
///
/// If no action widget is provided, a default empty `SizedBox` will be used.
///
/// The dialog includes a close button that uses the localized 'close' text and
/// closes the dialog when pressed.
///
/// Parameters:
/// - `title`: The title of the dialog. Defaults to an empty string.
/// - `content`: The content of the dialog. Defaults to an empty `SizedBox`.
/// - `action`: An optional widget to display as an action button. Defaults to `null`.
void showAppDialog({String title = '', Widget content = const SizedBox(), Widget? action}) {
  final l10n = this.l10n;
  final colorScheme = Theme.of(this).colorScheme;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: this,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: colorScheme.primary,
        title: Text(title, style: displayLarge?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        content: content,
        actions: <Widget>[
          ...[action ?? const SizedBox()],
          OutlinedButton(
            style: ButtonStyle(side: WidgetStateProperty.all(BorderSide.none)),
            child: Text(l10n.close, style: bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
}
