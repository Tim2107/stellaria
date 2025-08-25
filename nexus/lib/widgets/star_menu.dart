import 'package:flutter/material.dart';

import 'sparkle.dart';

class StarMenu extends StatefulWidget {
  final bool isDark;

  const StarMenu({super.key, required this.isDark});

  @override
  State<StarMenu> createState() => _StarMenuState();
}

class _StarMenuState extends State<StarMenu> with SingleTickerProviderStateMixin {
  bool _open = false;
  bool _hovering = false;

  static const double _spacing = 8;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_open) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _open = !_open);
  }

  @override
  Widget build(BuildContext context) {
    final starColor = widget.isDark ? Colors.grey[300]! : Colors.grey[800]!;
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: InkWell(
            onTap: _toggle,
            child: Sparkle(
              size: 32,
              color: starColor,
              animate: _hovering,
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: FadeTransition(
            opacity: animation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: _spacing),
                Tooltip(
                  message: 'explore stellaria',
                  child: _buildOption(
                    icon: Icons.travel_explore,
                    onTap: () {
                      // Placeholder for portal action
                    },
                  ),
                ),
                const SizedBox(height: _spacing),
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
            ),
          ),
        ),
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
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(icon, color: Colors.white),
                ),
                // create a subtle highlight for a glassy 3D effect
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.0),
                          ],
                          center: Alignment.topLeft,
                          radius: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

