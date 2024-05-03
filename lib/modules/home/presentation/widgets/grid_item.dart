import 'package:flutter/material.dart';
import 'package:quran_app/common/common.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.item, required this.onTap});

  final MenuItem item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: backgroundColor2.withOpacity(.15)),
      ),
      child: Center(
        child: ListTile(
          onTap: onTap,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          // splashColor: Colors.transparent,
          dense: true,
          contentPadding: const EdgeInsets.all(14),
          horizontalTitleGap: 5,
          visualDensity: VisualDensity.comfortable,
          leading: item.icon,
          title: Text(
            item.title,
            // textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: smallText.copyWith(color: backgroundColor2),
          ),
        ),
      ),
    );
  }
}
