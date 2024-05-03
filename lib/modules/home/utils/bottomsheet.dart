import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
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
                    color: backgroundColor,
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
                      style: mediumText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: backgroundColor2,
                      ),
                    ),
                    iconColor: backgroundColor2,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      Text(
                        doaDaily[index].arabic ?? '',
                        style: arabicText,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        doaDaily[index].latin ?? '',
                        style: inputLabel.copyWith(
                          color: backgroundColor2.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Divider(
                        color: backgroundColor2.withOpacity(.5),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doaDaily[index].translation ?? '',
                        style: inputLabel.copyWith(
                          color: backgroundColor2.withOpacity(0.7),
                        ),
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
