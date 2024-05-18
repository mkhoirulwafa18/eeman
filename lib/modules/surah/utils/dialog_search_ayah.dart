import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/input_box.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void showSearchAyahDialog(
  BuildContext context,
  TextEditingController controller,
  ItemScrollController scrollController,
  int totalAyat,
) {
  final l10n = context.l10n;
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor2,
        title: Text(
          l10n.findAyah,
          style: lightBoldTitle,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.totalAyat(totalAyat.toString()),
              style: smallText,
            ),
            const EemanSpacing.vertical8(),
            InputBox(
              labelText: l10n.whatAyah,
              controller: controller,
              maxLength: 3,
              autofocus: true,
              keyboardType: TextInputType.number,
              formatter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ),
        actions: <Widget>[
          OutlinedButton(
            child: Text(
              l10n.close,
              style: smallText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          OutlinedButton(
            child: Text(
              l10n.find,
              style: smallText,
            ),
            onPressed: () {
              if (controller.value.text.isNotEmpty) {
                if (int.parse(controller.value.text) <= totalAyat) {
                  Navigator.of(context).pop();
                  scrollController.scrollTo(
                    index: int.parse(
                      controller.value.text,
                    ),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}
