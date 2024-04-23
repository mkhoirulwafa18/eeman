import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/extensions/dialog_extension.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/home/widgets/app_title.dart';
import 'package:quran_app/modules/home/widgets/header_card.dart';
import 'package:quran_app/modules/home/widgets/menu_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage.noPadding(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: CustomSliverDelegate(
              expandedHeight: MediaQuery.of(context).size.height / 5,
            ),
          ),
          const SliverToBoxAdapter(
            child: MenuList(),
          ),
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 3.5 - shrinkOffset;
    final l10n = context.l10n;
    return SizedBox(
      height: expandedHeight + expandedHeight / 1.5,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: backgroundColor2,
              centerTitle: true,
              title: const AppTitle(),
              actions: [
                GestureDetector(
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
                          style: smallText,
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
                      color: backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0,
            child: const Column(
              children: [
                SizedBox(height: 16),
                HeaderCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
