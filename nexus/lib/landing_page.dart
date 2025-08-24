import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/poems.dart';
import 'widgets/language_selector.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  bool _isDark = false;

  List<String> get _languages => poems.keys.toList();
  String get _currentLang => _languages[_selectedIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        color: _isDark ? Colors.black : Colors.white,
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns: animation,
                            child: FadeTransition(opacity: animation, child: child),
                          );
                        },
                        child: Text(
                          poems[_currentLang]!,
                          key: ValueKey(_currentLang + (_isDark ? 'dark' : 'light')),
                          textAlign: TextAlign.center,
                          style: _poemStyle(_currentLang).copyWith(
                            color: _isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            LanguageSelector(
              languages: _languages,
              selectedIndex: _selectedIndex,
              isDark: _isDark,
              onChanged: (i) => setState(() {
                _selectedIndex = i;
                _isDark = !_isDark;
              }),
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
}
