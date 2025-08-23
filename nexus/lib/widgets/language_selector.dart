import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sparkle.dart';

class LanguageSelector extends StatefulWidget {
  final List<String> languages;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const LanguageSelector({
    super.key,
    required this.languages,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool _expanded = false;
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        FixedExtentScrollController(initialItem: widget.selectedIndex);
  }

  @override
  void didUpdateWidget(covariant LanguageSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.jumpToItem(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.languages[widget.selectedIndex];
    return Stack(
      children: [
        if (_expanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _expanded = false),
              behavior: HitTestBehavior.translucent,
            ),
          ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _expanded ? _buildWheel() : _buildCollapsed(lang),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsed(String lang) {
    return InkWell(
      onTap: () => setState(() => _expanded = true),
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
    return SizedBox(
      height: 150,
      width: 120,
      child: CupertinoPicker(
        scrollController: _controller,
        itemExtent: 50,
        onSelectedItemChanged: widget.onChanged,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.amber, width: 2),
          ),
        ),
        children: [
          for (var i = 0; i < widget.languages.length; i++)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.languages[i],
                    style: _languageStyle(
                        widget.languages[i], i == widget.selectedIndex),
                  ),
                  if (i == widget.selectedIndex) ...[
                    const SizedBox(width: 8),
                    const Sparkle(),
                  ]
                ],
              ),
            )
        ],
      ),
    );
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
