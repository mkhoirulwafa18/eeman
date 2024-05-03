import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/modules/home/domain/home_usecase.dart';
import 'package:quran_app/modules/home/presentation/blocs/cubit/home_cubit.dart';
import 'package:quran_app/modules/home/presentation/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(locator<HomeUseCaseImpl>())..init(DateTime.now()),
      child: const BasePage.noPadding(child: HomeView()),
    );
  }
}
