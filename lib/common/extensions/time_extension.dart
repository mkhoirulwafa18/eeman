import 'package:intl/intl.dart';

/// [TimeExtension] used for easy formatting [DateTime] into 'id' Locale .
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

extension TimeExtension on DateTime {
  String toLocalAndFormat(String format) {
    return Intl.withLocale('id', () => DateFormat(format).format(this)).toString();
  }
}
