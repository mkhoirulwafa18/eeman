import 'package:flutter/material.dart';
import 'package:quran_app/modules/home/widgets/glassmorphism.dart';

class BoxHeader extends StatelessWidget {
  const BoxHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xffb693d6),
                Color(0xffa07cc5),
                Color(0xff8966b5),
                Color(0xff7251a5),
                Color(0xff5a3c95),
                Color(0xff412886),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 2.5,
          ),
        ),
        Glassmorphism(
          blur: 8,
          opacity: 0.1,
          radius: 20,
          child: Container(
            height: MediaQuery.of(context).size.width / 2.5,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Ayat of the day',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Learn the best design here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
