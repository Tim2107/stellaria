import 'package:flutter/material.dart';

import 'sparkle.dart';

class StarMenu extends StatefulWidget {
  final bool isDark;

  const StarMenu({super.key, required this.isDark});

  @override
  State<StarMenu> createState() => _StarMenuState();
}

class _StarMenuState extends State<StarMenu> {
  bool _open = false;
  bool _hovering = false;

  static const double _hoverRadius = 40;

  @override
  Widget build(BuildContext context) {
    final starColor = widget.isDark ? Colors.grey[300]! : Colors.grey[800]!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onExit: (_) => setState(() => _hovering = false),
          onHover: (e) {
            final center = const Offset(_hoverRadius, _hoverRadius);
            final distance = (e.localPosition - center).distance;
            final close = distance <= _hoverRadius;
            if (close != _hovering) {
              setState(() => _hovering = close);
            }
          },
          child: SizedBox(
            width: _hoverRadius * 2,
            height: _hoverRadius * 2,
            child: Center(
              child: InkWell(
                onTap: () => setState(() => _open = !_open),
                child: Sparkle(
                  size: 32,
                  color: starColor,
                  animate: _hovering,
                ),
              ),
            ),
          ),
        ),
        if (_open) ...[
          const SizedBox(height: 8),
          Tooltip(
            message: 'explore stellaria',
            child: _buildOption(
              icon: Icons.travel_explore,
              onTap: () {
                // Placeholder for portal action
              },
            ),
          ),
          const SizedBox(height: 8),
          Tooltip(
            message: 'login',
            child: _buildOption(
              icon: Icons.login,
              onTap: () {
                // Placeholder for login action
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOption({required IconData icon, VoidCallback? onTap}) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4),
          BoxShadow(color: Colors.white24, offset: Offset(-2, -2), blurRadius: 4),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

