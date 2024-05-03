import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/l10n/l10n.dart';

class AppInfoAction extends StatelessWidget {
  const AppInfoAction({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.showAppDialog(
          title: l10n.appName,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.appInfo,
                style: smallText,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                l10n.feedbackInfo,
                style: smallText,
              ),
            ],
          ),
          action: ElevatedButton(
            child: Text(
              l10n.feedbackAndReport,
              style: smallText.copyWith(color: backgroundColor2),
            ),
            onPressed: () {
              Navigator.pop(context);
              BetterFeedback.of(context).show((feedback) async {
                // draft an email and send to developer
                final screenshotFilePath = await writeImageToStorage(feedback.screenshot);
                final email = Email(
                  body: feedback.text,
                  subject: 'Eeman App Feedback',
                  recipients: ['wafastarzteam@gmail.com'],
                  attachmentPaths: [screenshotFilePath],
                );
                await FlutterEmailSender.send(email);
              });
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Icon(
          Icons.info_outline_rounded,
          color: backgroundColor2,
        ),
      ),
    );
  }
}
