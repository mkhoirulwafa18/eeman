import 'package:flutter/material.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/themes/text_styles.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';

void showAppBottomSheet(BuildContext context, List<DoaDaily> doaDaily) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: ColoredBox(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              builder: (_, controller) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: BottomSheetDoaContent(
                    controller: controller,
                    doaDaily: doaDaily,
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

class BottomSheetDoaContent extends StatelessWidget {
  const BottomSheetDoaContent({
    super.key,
    required this.controller,
    required this.doaDaily,
  });
  final ScrollController controller;
  final List<DoaDaily> doaDaily;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.remove_outlined,
          size: 30,
          color: Colors.grey[600],
        ),
        if (doaDaily.isEmpty)
          const AppLoading()
        else
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: doaDaily.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ExpansionTile(
                    title: Text(
                      doaDaily[index].title ?? '',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    iconColor: Theme.of(context).colorScheme.onBackground,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      Text(
                        doaDaily[index].arabic ?? '',
                        style: AppTextStyles.arabicText,
                        textDirection: TextDirection.rtl,
                      ),
                      const EemanSpacing.vertical8(),
                      Text(
                        doaDaily[index].latin ?? '',
                        style: context.bodySmall
                            ?.copyWith(height: 1, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                      ),
                      const EemanSpacing.vertical4(),
                      Divider(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                      ),
                      const EemanSpacing.vertical4(),
                      Text(
                        doaDaily[index].translation ?? '',
                        style: context.bodySmall
                            ?.copyWith(height: 1, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
