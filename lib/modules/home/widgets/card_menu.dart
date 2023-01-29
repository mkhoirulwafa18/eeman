import 'package:flutter/material.dart';
import 'package:quran_app/common/constants/constant.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.bg,
  });

  final Color color;
  final Widget icon;
  final String title;
  final CirclePosition bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (bg == CirclePosition.doa)
            Positioned(
              left: -30,
              top: -20,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                radius: 70,
              ),
            )
          else
            bg == CirclePosition.quran
                ? Positioned(
                    right: -30,
                    bottom: -10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      radius: 70,
                    ),
                  )
                : bg == CirclePosition.shalat
                    ? Positioned(
                        right: -10,
                        bottom: -30,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          radius: 70,
                        ),
                      )
                    : Positioned(
                        left: -10,
                        top: -30,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          radius: 70,
                        ),
                      ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  icon,
                  Text(
                    title,
                    style: mediumText.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CirclePosition { doa, quran, shalat, tasbih }
