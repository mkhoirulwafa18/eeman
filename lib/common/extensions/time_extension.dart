import 'package:intl/intl.dart';

/// [TimeExtension] used for easy showing dialog anywhere in the app.
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

extension TimeExtension on DateTime {
  String toLocalAndFormat(String format) {
    return Intl.withLocale('id', () => DateFormat(format).format(this)).toString();
  }
}
