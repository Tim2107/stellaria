import 'package:flutter/material.dart';
import 'widgets/sparkle.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InteractiveViewer(
            maxScale: 5,
            child: CustomPaint(
              size: const Size(1000, 1000),
              painter: _StellariaMapPainter(),
            ),
          ),
          const Positioned(
            bottom: 16,
            right: 16,
            child: Sparkle(
              size: 48,
              animate: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _StellariaMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // background
    paint.color = Colors.lightGreen[100]!;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // forest in the west
    paint.color = Colors.green[700]!;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * 0.25, size.height),
      paint,
    );

    // forest in the south
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.25),
      paint,
    );

    // lake in the north
    paint.color = Colors.lightBlue[400]!;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.2),
        width: size.width * 0.3,
        height: size.height * 0.2,
      ),
      paint,
    );

    // mountains beyond the lake
    paint.color = Colors.grey[500]!;
    final mountain1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.05)
      ..lineTo(size.width * 0.3, size.height * 0.25)
      ..lineTo(size.width * 0.1, size.height * 0.25)
      ..close();
    canvas.drawPath(mountain1, paint);
    final mountain2 = Path()
      ..moveTo(size.width * 0.5, size.height * 0.05)
      ..lineTo(size.width * 0.6, size.height * 0.25)
      ..lineTo(size.width * 0.4, size.height * 0.25)
      ..close();
    canvas.drawPath(mountain2, paint);

    // house in the east
    paint.color = Colors.brown;
    final houseRect = Rect.fromLTWH(
      size.width * 0.7,
      size.height * 0.55,
      size.width * 0.1,
      size.height * 0.1,
    );
    canvas.drawRect(houseRect, paint);
    final roof = Path()
      ..moveTo(houseRect.left, houseRect.top)
      ..lineTo(houseRect.right, houseRect.top)
      ..lineTo(houseRect.center.dx, houseRect.top - size.height * 0.05)
      ..close();
    paint.color = Colors.red;
    canvas.drawPath(roof, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

