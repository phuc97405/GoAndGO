import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';

class CustomBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 5);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.32, 0);
    path.quadraticBezierTo(size.width * 0.37, 0, size.width * 0.43, 20);

    path.arcToPoint(Offset(size.width * 0.57, 20),
        radius: Radius.circular(0.0), clockwise: false);

    path.quadraticBezierTo(size.width * 0.63, 0, size.width * 0.67, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 5);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
