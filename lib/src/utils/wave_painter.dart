import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final bool hasBlur;
  WavePainter(this.animation, this.color, {this.hasBlur = false})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    if (hasBlur) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    }

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height - 30 + animation.value,
        size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4),
        size.height + 30 - animation.value, size.width, size.height);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
