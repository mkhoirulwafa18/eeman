import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/modules/tasbih/cubit/counter_cubit.dart';
import 'package:quran_app/modules/tasbih/widgets/custom_painter.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: CustomPaint(
            size: const Size(
              323,
              323 * 1.4086687306501549,
            ),
            painter: RPSCustomPainter(),
            child: BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundColor2.withOpacity(.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '0' * (6 - state.count.toString().length),
                              style: lightBoldTitle.copyWith(
                                fontFamily: 'DsDigital',
                                fontSize: 70,
                                color: backgroundColor.withOpacity(.2),
                              ),
                            ),
                            TextSpan(
                              text: state.count.toString(),
                              style: lightBoldTitle.copyWith(
                                fontFamily: 'DsDigital',
                                fontSize: 70,
                                // color: backgroundColor.withOpacity(.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.read<CounterCubit>().decrement(),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: backgroundColor2.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.undo_rounded,
                                color: backgroundColor2,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.read<CounterCubit>().reset(),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: backgroundColor2.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.replay_rounded,
                                color: backgroundColor2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => context.read<CounterCubit>().increment(),
                      child: Container(
                        width: 126,
                        height: 126,
                        decoration: BoxDecoration(
                          color: backgroundColor2,
                          shape: BoxShape.circle,
                          boxShadow: [primaryShadow],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
