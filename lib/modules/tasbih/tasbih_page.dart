import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/widgets/base_page.dart';
import 'package:quran_app/common/widgets/custom_app_bar.dart';
import 'package:quran_app/common/widgets/spacing.dart';
import 'package:quran_app/gen/fonts.gen.dart';
import 'package:quran_app/l10n/l10n.dart';
import 'package:quran_app/modules/tasbih/cubit/counter_cubit.dart';
import 'package:quran_app/modules/tasbih/widgets/custom_painter.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BasePage.noPadding(
        appBar: CustomAppBar(
          title: l10n.tasbihDigital,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: CustomPaint(
              size: const Size(
                323,
                323 * 1.4086687306501549,
              ),
              painter: RPSCustomPainter(context),
              child: BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: EemanSizes.s80 + EemanSizes.s8),
                      Container(
                        width: 320,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha:.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '0' * (6 - state.count.toString().length),
                                style: context.displayLarge?.copyWith(
                                  fontFamily: FontFamily.dsDigital,
                                  fontSize: 50,
                                  color: colorScheme.surface.withValues(alpha:.1),
                                ),
                              ),
                              TextSpan(
                                text: state.count.toString(),
                                style: context.displayLarge?.copyWith(
                                  fontFamily: FontFamily.dsDigital,
                                  color: colorScheme.secondary,
                                  fontSize: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const EemanSpacing.vertical32(),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => context.read<CounterCubit>().decrement(),
                              child: Container(
                                width: EemanSizes.s72,
                                height: EemanSizes.s72,
                                decoration: BoxDecoration(
                                  color: colorScheme.onSurface.withValues(alpha:.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.undo_rounded,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.read<CounterCubit>().reset(),
                              child: Container(
                                width: EemanSizes.s72,
                                height: EemanSizes.s72,
                                decoration: BoxDecoration(
                                  color: colorScheme.onSurface.withValues(alpha:.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.replay_rounded,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const EemanSpacing.vertical32(),
                      GestureDetector(
                        onTap: () {
                          context.read<CounterCubit>().increment();
                          HapticFeedback.mediumImpact();
                          SystemSound.play(SystemSoundType.click);
                        },
                        child: Container(
                          width: 126,
                          height: 126,
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface,
                            shape: BoxShape.circle,
                            boxShadow: [primaryShadow],
                          ),
                        ),
                      ),
                      const EemanSpacing.vertical52(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
