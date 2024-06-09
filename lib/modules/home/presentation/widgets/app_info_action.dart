import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/l10n/l10n.dart';

class AppInfoAction extends StatelessWidget {
  const AppInfoAction({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () {
        context.showAppDialog(
          title: l10n.appName,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.appInfo,
                style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              const EemanSpacing.vertical16(),
              Text(
                l10n.feedbackInfo,
                style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
          action: ElevatedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary)),
            child: Text(
              l10n.feedbackAndReport,
              style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.pop(context);
              BetterFeedback.of(context).show((feedback) async {
                // draft an email and send to developer
                final screenshotFilePath = await writeImageToStorage(feedback.screenshot);
                final email = Email(
                  body: feedback.text,
                  subject: l10n.emailFeedbackSubject,
                  recipients: [emailForReceivingEmailFeedback],
                  attachmentPaths: [screenshotFilePath],
                );
                await FlutterEmailSender.send(email);
              });
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: EemanSizes.s24),
        child: Icon(
          Icons.info_outline_rounded,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
