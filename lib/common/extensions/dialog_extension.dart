import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
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
///     style: mediumText,
///   ),
/// );
/// ```

extension DialogExtension on BuildContext {
  void showAppDialog({String title = '', Widget content = const SizedBox(), Widget? action}) {
    final l10n = this.l10n;
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor2,
          title: Text(
            title,
            style: lightBoldTitle,
          ),
          content: content,
          actions: <Widget>[
            ...[action ?? const SizedBox()],
            OutlinedButton(
              child: Text(
                l10n.close,
                style: smallText,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
