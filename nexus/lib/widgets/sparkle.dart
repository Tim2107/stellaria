import 'package:flutter/material.dart';

class Sparkle extends StatefulWidget {
  final Color color;
  final double size;
  final bool animate;

  const Sparkle(
      {super.key,
      this.color = const Color(0xFFB3E5FC),
      this.size = 12,
      this.animate = true});

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
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant Sparkle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
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
        final t = widget.animate ? _controller.value : 0.5;
        final color =
            Color.lerp(widget.color.withOpacity(0.6), widget.color, t)!;
        final size = widget.size * (0.8 + 0.4 * t);
        return Container(
          alignment: Alignment.center,
          width: size,
          height: size,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.7),
              blurRadius: 8 * t + 2,
            )
          ]),
          child: Icon(
            Icons.star,
            color: color,
            size: size,
          ),
        );
      },
    );
  }
}
