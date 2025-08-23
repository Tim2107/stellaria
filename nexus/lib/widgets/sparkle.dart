import 'package:flutter/material.dart';

class Sparkle extends StatefulWidget {
  const Sparkle({super.key});

  @override
  State<Sparkle> createState() => _SparkleState();
}

class _SparkleState extends State<Sparkle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final base = Colors.amber;
        final color = Color.lerp(Colors.amber[200], base, t)!;
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.7),
                blurRadius: 6 * t + 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
