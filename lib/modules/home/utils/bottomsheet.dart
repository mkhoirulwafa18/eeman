import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/app_loading.dart';
import 'package:quran_app/modules/home/models/doa_daily.dart';

void showAppBottomSheet(BuildContext context) {
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

class BottomSheetDoaContent extends StatefulWidget {
  const BottomSheetDoaContent({
    super.key,
    required this.controller,
  });
  final ScrollController controller;

  @override
  State<BottomSheetDoaContent> createState() => _BottomSheetDoaContentState();
}

class _BottomSheetDoaContentState extends State<BottomSheetDoaContent> {
  List<DoaDaily> _doa = [];
  List<DoaDaily> _doaData = [];

  Future<void> readJson() async {
    final doaResponse = await rootBundle.loadString('assets/sources/doa.json');
    final doaData = doaDailyFromJson(doaResponse);
    setState(() {
      _doaData = doaData;
      _doa = doaData;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.remove_outlined,
          size: 30,
          color: Colors.grey[600],
        ),
        if (_doa.isEmpty)
          const AppLoading()
        else
          Expanded(
            child: ListView.builder(
              controller: widget.controller,
              itemCount: _doaData.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ExpansionTile(
                    title: Text(
                      _doa[index].title ?? '',
                      style: mediumText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: backgroundColor2,
                      ),
                    ),
                    children: [
                      Text(
                        _doa[index].arabic ?? '',
                        style: arabicText,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _doa[index].latin ?? '',
                        style: inputText.copyWith(color: backgroundColor2),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _doa[index].translation ?? '',
                        style: inputText.copyWith(color: backgroundColor2),
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
