import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sparkle.dart';

class LanguageSelector extends StatefulWidget {
  final List<String> languages;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool isDark;

  const LanguageSelector({
    super.key,
    required this.languages,
    required this.selectedIndex,
    required this.onChanged,
    required this.isDark,
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
    if (oldWidget.selectedIndex != widget.selectedIndex &&
        _controller.hasClients) {
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
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: _expanded ? _buildWheel() : _buildCollapsed(lang),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsed(String lang) {
    return InkWell(
      onTap: () {
        _controller.dispose();
        _controller =
            FixedExtentScrollController(initialItem: widget.selectedIndex);
        setState(() => _expanded = true);
      },
      child: Text(
        lang,
        style: _languageStyle(
            lang, false, widget.isDark ? Colors.white : const Color(0xFF5E35B1)),
      ),
    );
  }

  Widget _buildWheel() {
    return Focus(
      autofocus: true,
      onKey: (node, event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            final newIndex = _controller.selectedItem > 0
                ? _controller.selectedItem - 1
                : _controller.selectedItem;
            if (newIndex != _controller.selectedItem) {
              _controller.animateToItem(newIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            }
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            final newIndex = _controller.selectedItem < widget.languages.length - 1
                ? _controller.selectedItem + 1
                : _controller.selectedItem;
            if (newIndex != _controller.selectedItem) {
              _controller.animateToItem(newIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            }
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: SizedBox(
        height: 150,
        width: 120,
        child: CupertinoPicker(
          scrollController: _controller,
          itemExtent: 50,
          onSelectedItemChanged: widget.onChanged,
          selectionOverlay: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [Color(0x66D1C4E9), Color(0x66BBDEFB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 6,
                left: 10,
                child: Sparkle(size: 10, color: Colors.white),
              ),
              const Positioned(
                bottom: 6,
                right: 10,
                child: Sparkle(size: 10, color: Color(0xFF81D4FA)),
              ),
            ],
          ),
          children: [
            for (var i = 0; i < widget.languages.length; i++)
              Center(
                child: Text(
                  widget.languages[i],
                  style: _languageStyle(
                      widget.languages[i], i == widget.selectedIndex),
                ),
              )
          ],
        ),
      ),
    );
  }

  TextStyle _languageStyle(String language, bool selected, [Color? color]) {
    TextStyle base;
    switch (language) {
      case '日本語':
        base = GoogleFonts.notoSerifJp(fontSize: 20);
        break;
      default:
        base = GoogleFonts.ebGaramond(fontSize: 20);
    }
    return base.copyWith(
      color: color ??
          (selected
              ? (widget.isDark ? Colors.white : Colors.black)
              : (widget.isDark ? Colors.white70 : Colors.black87)),
    );
  }
}
