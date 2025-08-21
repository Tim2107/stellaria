import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const NexusApp());

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus',
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static const _poem = '''
Under starlit skies
a h(e)aven waits
where secrets bloom and dreams create
And silence whispers,
wild, unseen,
inviting hearts to craft, convene...
and if you find a wondrous gem,
share...
and let it shine

The dreamers manifest(o)
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _poem,
            textAlign: TextAlign.center,
            style: GoogleFonts.ebGaramond(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

