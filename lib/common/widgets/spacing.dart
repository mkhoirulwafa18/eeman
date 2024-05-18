import 'package:flutter/material.dart';

class EemanSpacing extends StatelessWidget {
  const EemanSpacing.vertical({
    super.key,
    required this.size,
  }) : axis = Axis.vertical;
  const EemanSpacing.vertical4({super.key})
      : size = 4,
        axis = Axis.vertical;
  const EemanSpacing.vertical8({super.key})
      : size = 8,
        axis = Axis.vertical;
  const EemanSpacing.vertical12({super.key})
      : size = 12,
        axis = Axis.vertical;
  const EemanSpacing.vertical16({super.key})
      : size = 16,
        axis = Axis.vertical;
  const EemanSpacing.vertical20({super.key})
      : size = 20,
        axis = Axis.vertical;
  const EemanSpacing.vertical24({super.key})
      : size = 24,
        axis = Axis.vertical;
  const EemanSpacing.vertical28({super.key})
      : size = 28,
        axis = Axis.vertical;
  const EemanSpacing.vertical32({super.key})
      : size = 32,
        axis = Axis.vertical;
  const EemanSpacing.vertical36({super.key})
      : size = 36,
        axis = Axis.vertical;
  const EemanSpacing.vertical40({super.key})
      : size = 40,
        axis = Axis.vertical;
  const EemanSpacing.vertical44({super.key})
      : size = 44,
        axis = Axis.vertical;
  const EemanSpacing.vertical48({super.key})
      : size = 48,
        axis = Axis.vertical;
  const EemanSpacing.vertical52({super.key})
      : size = 52,
        axis = Axis.vertical;
  const EemanSpacing.vertical56({super.key})
      : size = 56,
        axis = Axis.vertical;
  const EemanSpacing.vertical60({super.key})
      : size = 60,
        axis = Axis.vertical;
  const EemanSpacing.vertical64({super.key})
      : size = 64,
        axis = Axis.vertical;
  const EemanSpacing.vertical68({super.key})
      : size = 68,
        axis = Axis.vertical;
  const EemanSpacing.vertical72({super.key})
      : size = 72,
        axis = Axis.vertical;
  const EemanSpacing.vertical76({super.key})
      : size = 76,
        axis = Axis.vertical;
  const EemanSpacing.vertical80({super.key})
      : size = 80,
        axis = Axis.vertical;

  const EemanSpacing.horizontal({
    super.key,
    required this.size,
  }) : axis = Axis.horizontal;
  const EemanSpacing.horizontal4({super.key})
      : size = 4,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal8({super.key})
      : size = 8,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal12({super.key})
      : size = 12,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal16({super.key})
      : size = 16,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal20({super.key})
      : size = 20,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal24({super.key})
      : size = 24,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal28({super.key})
      : size = 28,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal32({super.key})
      : size = 32,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal36({super.key})
      : size = 36,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal40({super.key})
      : size = 40,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal44({super.key})
      : size = 44,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal48({super.key})
      : size = 48,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal52({super.key})
      : size = 52,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal56({super.key})
      : size = 56,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal60({super.key})
      : size = 60,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal64({super.key})
      : size = 64,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal68({super.key})
      : size = 68,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal72({super.key})
      : size = 72,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal76({super.key})
      : size = 76,
        axis = Axis.horizontal;
  const EemanSpacing.horizontal80({super.key})
      : size = 80,
        axis = Axis.horizontal;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.horizontal ? SizedBox(width: size) : SizedBox(height: size);
  }
}
