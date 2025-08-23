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

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _languages = const ['English', 'Deutsch', 'Français', '日本語'];

  final _poems = const {
    'English': '''
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
''',
    'Deutsch': '''
Unter sternenklaren Weiten
findet sich ein geborgener Ort
an dem Geheimnisse verborgen blühen 
und Träume Welten schaffen.
Und wo es durch die Stille raunt,
ungezähmt und heimlich
und Herzen zusammen ruft sich im Erschaffen zu vereinen.

und findest Du hier Kostbarkeiten
lass sie uns Teilen
und staunen ihrer Wunder
''',
    'Français': '''
Sous les cieux embrasés d’étoiles,
un sanctuaire frémissant attend,
où les secrets s’ouvrent comme des fleurs interdites,
et les rêves enfantent des mondes de fièvre.

Le silence soupire,
ardent, insaisissable,
et ses murmures effleurent la peau du cœur,
l’invitant à se perdre, à se fondre, à créer.

Et si tes mains découvrent un joyau rare,
ne le garde pas —
offre-le,
qu’il resplendisse, qu’il consume, qu’il enivre.
''',
    '日本語': '''
星空の下
あなたの館が待っている
秘密は咲き、
夢は世界を創り出す

沈黙はささやき、
野生のまま見えぬもの、
心を誘い、
創造へと集う

そして、めずらしい宝石を見つけたなら
分かち合い、輝かせよ
'''
  };

  int _selected = 0;
  bool _showSelector = false;
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = _languages[_selected];

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Text(
                      _poems[lang]!,
                      textAlign: TextAlign.center,
                      style: _poemStyle(lang),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _showSelector ? _buildWheel() : _buildCollapsed(lang),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _poemStyle(String language) {
    switch (language) {
      case '日本語':
        return GoogleFonts.notoSerifJp(fontSize: 24);
      default:
        return GoogleFonts.ebGaramond(fontSize: 24);
    }
  }

  TextStyle _languageStyle(String language, bool selected) {
    TextStyle base;
    switch (language) {
      case '日本語':
        base = GoogleFonts.notoSerifJp(fontSize: 20);
        break;
      default:
        base = GoogleFonts.ebGaramond(fontSize: 20);
    }
    return base.copyWith(
      color: selected ? Colors.amber[800] : Colors.black87,
    );
  }

  Widget _buildCollapsed(String lang) {
    return GestureDetector(
      onTap: () => setState(() => _showSelector = true),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(lang, style: _languageStyle(lang, true)),
          const SizedBox(width: 8),
          const Sparkle(),
        ],
      ),
    );
  }

  Widget _buildWheel() {
    return GestureDetector(
      onTap: () => setState(() => _showSelector = false),
      child: SizedBox(
        height: 150,
        width: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: 50,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) =>
                  setState(() => _selected = index),
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= _languages.length) return null;
                  final language = _languages[index];
                  final selected = index == _selected;
                  return Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          language,
                          style: _languageStyle(language, selected),
                        ),
                        if (selected) ...[
                          const SizedBox(width: 8),
                          const Sparkle(),
                        ]
                      ],
                    ),
                  );
                },
                childCount: _languages.length,
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

