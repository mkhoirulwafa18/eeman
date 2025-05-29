// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  const RPSCustomPainter(this.context);
  final BuildContext context;
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.3549451);
    path_0.lineTo(size.width, size.height * 0.5868132);
    path_0.cubicTo(
      size.width,
      size.height * 0.6515319,
      size.width * 0.9501207,
      size.height * 0.7079802,
      size.width * 0.8761610,
      size.height * 0.7378418,
    );
    path_0.lineTo(size.width * 0.8761610, size.height * 0.7582418);
    path_0.cubicTo(
      size.width * 0.8761610,
      size.height * 0.8917604,
      size.width * 0.7236873,
      size.height,
      size.width * 0.5356037,
      size.height,
    );
    path_0.lineTo(size.width * 0.4643963, size.height);
    path_0.cubicTo(
      size.width * 0.2763118,
      size.height,
      size.width * 0.1238390,
      size.height * 0.8917604,
      size.width * 0.1238390,
      size.height * 0.7582418,
    );
    path_0.lineTo(size.width * 0.1238390, size.height * 0.7378418);
    path_0.cubicTo(
      size.width * 0.04988050,
      size.height * 0.7079802,
      0,
      size.height * 0.6515319,
      0,
      size.height * 0.5868132,
    );
    path_0.lineTo(0, size.height * 0.3549451);
    path_0.lineTo(0, size.height * 0.2703297);
    path_0.cubicTo(
      0,
      size.height * 0.2043229,
      size.width * 0.05188545,
      size.height * 0.1469189,
      size.width * 0.1282830,
      size.height * 0.1175501,
    );
    path_0.cubicTo(
      size.width * 0.2198046,
      size.height * 0.04537846,
      size.width * 0.3524365,
      0,
      size.width * 0.5000000,
      0,
    );
    path_0.cubicTo(
      size.width * 0.6475635,
      0,
      size.width * 0.7801950,
      size.height * 0.04537846,
      size.width * 0.8717183,
      size.height * 0.1175501,
    );
    path_0.cubicTo(
      size.width * 0.9481146,
      size.height * 0.1469189,
      size.width,
      size.height * 0.2043229,
      size.width,
      size.height * 0.2703297,
    );
    path_0.lineTo(size.width, size.height * 0.3549451);
    path_0.close();

    final paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withValues(alpha:1);
    canvas.drawPath(path_0, paint0Fill);

    final path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.3549451);
    path_1.lineTo(size.width, size.height * 0.5868132);
    path_1.cubicTo(
      size.width,
      size.height * 0.6515319,
      size.width * 0.9501207,
      size.height * 0.7079802,
      size.width * 0.8761610,
      size.height * 0.7378418,
    );
    path_1.lineTo(size.width * 0.8761610, size.height * 0.7582418);
    path_1.cubicTo(
      size.width * 0.8761610,
      size.height * 0.8917604,
      size.width * 0.7236873,
      size.height,
      size.width * 0.5356037,
      size.height,
    );
    path_1.lineTo(size.width * 0.4643963, size.height);
    path_1.cubicTo(
      size.width * 0.2763118,
      size.height,
      size.width * 0.1238390,
      size.height * 0.8917604,
      size.width * 0.1238390,
      size.height * 0.7582418,
    );
    path_1.lineTo(size.width * 0.1238390, size.height * 0.7378418);
    path_1.cubicTo(
      size.width * 0.04988050,
      size.height * 0.7079802,
      0,
      size.height * 0.6515319,
      0,
      size.height * 0.5868132,
    );
    path_1.lineTo(0, size.height * 0.3549451);
    path_1.lineTo(0, size.height * 0.2703297);
    path_1.cubicTo(
      0,
      size.height * 0.2043229,
      size.width * 0.05188545,
      size.height * 0.1469189,
      size.width * 0.1282830,
      size.height * 0.1175501,
    );
    path_1.cubicTo(
      size.width * 0.2198046,
      size.height * 0.04537846,
      size.width * 0.3524365,
      0,
      size.width * 0.5000000,
      0,
    );
    path_1.cubicTo(
      size.width * 0.6475635,
      0,
      size.width * 0.7801950,
      size.height * 0.04537846,
      size.width * 0.8717183,
      size.height * 0.1175501,
    );
    path_1.cubicTo(
      size.width * 0.9481146,
      size.height * 0.1469189,
      size.width,
      size.height * 0.2043229,
      size.width,
      size.height * 0.2703297,
    );
    path_1.lineTo(size.width, size.height * 0.3549451);
    path_1.close();

    final paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Theme.of(context).colorScheme.surface.withValues(alpha:1);
    canvas.drawPath(path_1, paint1Fill);

    final path_2 = Path();
    path_2.moveTo(size.width * 0.8761610, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.8470805, size.height * 0.7015429);
    path_2.lineTo(size.width * 0.8173375, size.height * 0.7135516);
    path_2.lineTo(size.width * 0.8173375, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.8761610, size.height * 0.7378418);
    path_2.close();
    path_2.moveTo(size.width * 0.1238390, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.1826625, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.1826625, size.height * 0.7135516);
    path_2.lineTo(size.width * 0.1529207, size.height * 0.7015429);
    path_2.lineTo(size.width * 0.1238390, size.height * 0.7378418);
    path_2.close();
    path_2.moveTo(size.width * 0.1282830, size.height * 0.1175501);
    path_2.lineTo(size.width * 0.1562938, size.height * 0.1542699);
    path_2.lineTo(size.width * 0.1652142, size.height * 0.1508407);
    path_2.lineTo(size.width * 0.1720012, size.height * 0.1454886);
    path_2.lineTo(size.width * 0.1282830, size.height * 0.1175501);
    path_2.close();
    path_2.moveTo(size.width * 0.8717183, size.height * 0.1175501);
    path_2.lineTo(size.width * 0.8280000, size.height * 0.1454886);
    path_2.lineTo(size.width * 0.8347864, size.height * 0.1508409);
    path_2.lineTo(size.width * 0.8437059, size.height * 0.1542699);
    path_2.lineTo(size.width * 0.8717183, size.height * 0.1175501);
    path_2.close();
    path_2.moveTo(size.width * 1.058824, size.height * 0.5868132);
    path_2.lineTo(size.width * 1.058824, size.height * 0.3549451);
    path_2.lineTo(size.width * 0.9411765, size.height * 0.3549451);
    path_2.lineTo(size.width * 0.9411765, size.height * 0.5868132);
    path_2.lineTo(size.width * 1.058824, size.height * 0.5868132);
    path_2.close();
    path_2.moveTo(size.width * 0.9052415, size.height * 0.7741407);
    path_2.cubicTo(
      size.width * 0.9968359,
      size.height * 0.7371582,
      size.width * 1.058824,
      size.height * 0.6671516,
      size.width * 1.058824,
      size.height * 0.5868132,
    );
    path_2.lineTo(size.width * 0.9411765, size.height * 0.5868132);
    path_2.cubicTo(
      size.width * 0.9411765,
      size.height * 0.6359121,
      size.width * 0.9034025,
      size.height * 0.6788022,
      size.width * 0.8470805,
      size.height * 0.7015429,
    );
    path_2.lineTo(size.width * 0.9052415, size.height * 0.7741407);
    path_2.close();
    path_2.moveTo(size.width * 0.9349845, size.height * 0.7582418);
    path_2.lineTo(size.width * 0.9349845, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.8173375, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.8173375, size.height * 0.7582418);
    path_2.lineTo(size.width * 0.9349845, size.height * 0.7582418);
    path_2.close();
    path_2.moveTo(size.width * 0.5356037, size.height * 1.041758);
    path_2.cubicTo(
      size.width * 0.7561765,
      size.height * 1.041758,
      size.width * 0.9349845,
      size.height * 0.9148242,
      size.width * 0.9349845,
      size.height * 0.7582418,
    );
    path_2.lineTo(size.width * 0.8173375, size.height * 0.7582418);
    path_2.cubicTo(
      size.width * 0.8173375,
      size.height * 0.8686989,
      size.width * 0.6912012,
      size.height * 0.9582418,
      size.width * 0.5356037,
      size.height * 0.9582418,
    );
    path_2.lineTo(size.width * 0.5356037, size.height * 1.041758);
    path_2.close();
    path_2.moveTo(size.width * 0.4643963, size.height * 1.041758);
    path_2.lineTo(size.width * 0.5356037, size.height * 1.041758);
    path_2.lineTo(size.width * 0.5356037, size.height * 0.9582418);
    path_2.lineTo(size.width * 0.4643963, size.height * 0.9582418);
    path_2.lineTo(size.width * 0.4643963, size.height * 1.041758);
    path_2.close();
    path_2.moveTo(size.width * 0.06501548, size.height * 0.7582418);
    path_2.cubicTo(
      size.width * 0.06501548,
      size.height * 0.9148242,
      size.width * 0.2438245,
      size.height * 1.041758,
      size.width * 0.4643963,
      size.height * 1.041758,
    );
    path_2.lineTo(size.width * 0.4643963, size.height * 0.9582418);
    path_2.cubicTo(
      size.width * 0.3087991,
      size.height * 0.9582418,
      size.width * 0.1826625,
      size.height * 0.8686989,
      size.width * 0.1826625,
      size.height * 0.7582418,
    );
    path_2.lineTo(size.width * 0.06501548, size.height * 0.7582418);
    path_2.close();
    path_2.moveTo(size.width * 0.06501548, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.06501548, size.height * 0.7582418);
    path_2.lineTo(size.width * 0.1826625, size.height * 0.7582418);
    path_2.lineTo(size.width * 0.1826625, size.height * 0.7378418);
    path_2.lineTo(size.width * 0.06501548, size.height * 0.7378418);
    path_2.close();
    path_2.moveTo(size.width * -0.05882353, size.height * 0.5868132);
    path_2.cubicTo(
      size.width * -0.05882353,
      size.height * 0.6671516,
      size.width * 0.003164272,
      size.height * 0.7371582,
      size.width * 0.09475728,
      size.height * 0.7741407,
    );
    path_2.lineTo(size.width * 0.1529207, size.height * 0.7015429);
    path_2.cubicTo(
      size.width * 0.09659659,
      size.height * 0.6788022,
      size.width * 0.05882353,
      size.height * 0.6359121,
      size.width * 0.05882353,
      size.height * 0.5868132,
    );
    path_2.lineTo(size.width * -0.05882353, size.height * 0.5868132);
    path_2.close();
    path_2.moveTo(size.width * -0.05882353, size.height * 0.3549451);
    path_2.lineTo(size.width * -0.05882353, size.height * 0.5868132);
    path_2.lineTo(size.width * 0.05882353, size.height * 0.5868132);
    path_2.lineTo(size.width * 0.05882353, size.height * 0.3549451);
    path_2.lineTo(size.width * -0.05882353, size.height * 0.3549451);
    path_2.close();
    path_2.moveTo(size.width * -0.05882353, size.height * 0.2703297);
    path_2.lineTo(size.width * -0.05882353, size.height * 0.3549451);
    path_2.lineTo(size.width * 0.05882353, size.height * 0.3549451);
    path_2.lineTo(size.width * 0.05882353, size.height * 0.2703297);
    path_2.lineTo(size.width * -0.05882353, size.height * 0.2703297);
    path_2.close();
    path_2.moveTo(size.width * 0.1002718, size.height * 0.08083011);
    path_2.cubicTo(
      size.width * 0.005651115,
      size.height * 0.1172046,
      size.width * -0.05882353,
      size.height * 0.1883910,
      size.width * -0.05882353,
      size.height * 0.2703297,
    );
    path_2.lineTo(size.width * 0.05882353, size.height * 0.2703297);
    path_2.cubicTo(
      size.width * 0.05882353,
      size.height * 0.2202549,
      size.width * 0.09811981,
      size.height * 0.1766334,
      size.width * 0.1562938,
      size.height * 0.1542699,
    );
    path_2.lineTo(size.width * 0.1002718, size.height * 0.08083011);
    path_2.close();
    path_2.moveTo(size.width * 0.1720012, size.height * 0.1454886);
    path_2.cubicTo(
      size.width * 0.2528390,
      size.height * 0.08174220,
      size.width * 0.3698019,
      size.height * 0.04175824,
      size.width * 0.5000000,
      size.height * 0.04175824,
    );
    path_2.lineTo(size.width * 0.5000000, size.height * -0.04175824);
    path_2.cubicTo(
      size.width * 0.3350712,
      size.height * -0.04175824,
      size.width * 0.1867706,
      size.height * 0.009014703,
      size.width * 0.08456440,
      size.height * 0.08961143,
    );
    path_2.lineTo(size.width * 0.1720012, size.height * 0.1454886);
    path_2.close();
    path_2.moveTo(size.width * 0.5000000, size.height * 0.04175824);
    path_2.cubicTo(
      size.width * 0.6301981,
      size.height * 0.04175824,
      size.width * 0.7471610,
      size.height * 0.08174220,
      size.width * 0.8280000,
      size.height * 0.1454886,
    );
    path_2.lineTo(size.width * 0.9154365, size.height * 0.08961143);
    path_2.cubicTo(
      size.width * 0.8132291,
      size.height * 0.009014725,
      size.width * 0.6649288,
      size.height * -0.04175824,
      size.width * 0.5000000,
      size.height * -0.04175824,
    );
    path_2.lineTo(size.width * 0.5000000, size.height * 0.04175824);
    path_2.close();
    path_2.moveTo(size.width * 1.058824, size.height * 0.2703297);
    path_2.cubicTo(
      size.width * 1.058824,
      size.height * 0.1883910,
      size.width * 0.9943498,
      size.height * 0.1172046,
      size.width * 0.8997276,
      size.height * 0.08083011,
    );
    path_2.lineTo(size.width * 0.8437059, size.height * 0.1542699);
    path_2.cubicTo(
      size.width * 0.9018793,
      size.height * 0.1766334,
      size.width * 0.9411765,
      size.height * 0.2202549,
      size.width * 0.9411765,
      size.height * 0.2703297,
    );
    path_2.lineTo(size.width * 1.058824, size.height * 0.2703297);
    path_2.close();
    path_2.moveTo(size.width * 1.058824, size.height * 0.3549451);
    path_2.lineTo(size.width * 1.058824, size.height * 0.2703297);
    path_2.lineTo(size.width * 0.9411765, size.height * 0.2703297);
    path_2.lineTo(size.width * 0.9411765, size.height * 0.3549451);
    path_2.lineTo(size.width * 1.058824, size.height * 0.3549451);
    path_2.close();

    final paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff234D60).withValues(alpha:1);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
