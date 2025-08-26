import 'package:flutter/material.dart';
import 'widgets/sparkle.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              maxScale: 5,
              child: Image.asset(
                'assets/map.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) =>
                    const Center(child: Text('Map image missing')),
              ),
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
