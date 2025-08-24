import 'package:flutter/material.dart';

import 'sparkle.dart';

class StarMenu extends StatefulWidget {
  const StarMenu({super.key});

  @override
  State<StarMenu> createState() => _StarMenuState();
}

class _StarMenuState extends State<StarMenu> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_open) ...[
          Tooltip(
            message: 'explore stellaria',
            child: _buildOption(
              icon: Icons.travel_explore,
              onTap: () {
                // Placeholder for portal action
              },
            ),
          ),
          const SizedBox(width: 8),
          Tooltip(
            message: 'login',
            child: _buildOption(
              icon: Icons.login,
              onTap: () {
                // Placeholder for login action
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
        InkWell(
          onTap: () => setState(() => _open = !_open),
          child: const Sparkle(size: 32, color: Color(0xFFFFD700)),
        ),
      ],
    );
  }

  Widget _buildOption({required IconData icon, VoidCallback? onTap}) {
    return Material(
      color: Colors.deepPurpleAccent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

