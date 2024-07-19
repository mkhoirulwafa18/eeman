import 'package:flutter/material.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.item, required this.onTap});

  final MenuItem item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(180),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(.15)),
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
            style: context.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
