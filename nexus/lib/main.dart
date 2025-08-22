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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: ListWheelScrollView.useDelegate(
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
                            const Icon(Icons.auto_awesome,
                                color: Colors.amber),
                          ]
                        ],
                      ),
                    );
                  },
                  childCount: _languages.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                _poems[lang]!,
                textAlign: TextAlign.center,
                style: _poemStyle(lang),
              ),
            ),
          ],
        ),
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
}

