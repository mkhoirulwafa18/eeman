// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/surah_list/domain/surah_list_usecase.dart';
import 'package:quran_app/modules/surah_list/presentation/blocs/cubit/surah_list_cubit.dart';
import 'package:quran_app/modules/surah_list/presentation/widgets/surah_list_view.dart';

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurahListCubit(locator<SurahListUseCaseImpl>()),
      child: const SurahListView(),
    );
  }
}
