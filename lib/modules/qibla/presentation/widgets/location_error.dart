import 'package:flutter/material.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/l10n/l10n.dart';

class LocationErrorWidget extends StatelessWidget {
  const LocationErrorWidget({super.key, this.error, this.callback});
  final String? error;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    const box = EemanSpacing.vertical32();
    const errorColor = Color(0xffb00020);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: errorColor,
          ),
          box,
          Text(
            error!,
            style: const TextStyle(color: errorColor, fontWeight: FontWeight.bold),
          ),
          box,
          ElevatedButton(
            child: Text(context.l10n.retry),
            onPressed: () {
              // ignore: avoid_dynamic_calls, prefer_null_aware_method_calls
              if (callback != null) callback!();
            },
          ),
        ],
      ),
    );
  }
}
