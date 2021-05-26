// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:ui' as ui;

// class ImageEditor extends CustomPainter {
//   ImageEditor({
//     this.image,
//   });

//   ui.Image image;

//   @override
//   void paint(Canvas canvas, Size size) async {
//     canvas.drawImage(image, new Offset(0, -size.height * 0.8),
//         new Paint()..style = PaintingStyle.fill);

//     final radius = math.min(size.width, size.height) / 8;
//     final center = Offset(50, 50);
//     Paint paintCircle = Paint()..color = Colors.black;
//     Paint paintBorder = Paint()
//       ..color = Colors.white
//       ..strokeWidth = size.width / 36
//       ..style = PaintingStyle.stroke;
//     canvas.drawCircle(center, radius, paintCircle);
//     canvas.drawCircle(center, radius, paintBorder);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
