import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

class CodingKeys extends StatefulWidget {
  const CodingKeys({super.key, required this.codeController});
  final CodeController codeController;

  @override
  State<CodingKeys> createState() => _CodingKeysState();
}

class _CodingKeysState extends State<CodingKeys> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildCodingKeyButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          foregroundColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: child,
      ),
    );
  }

  Widget _buildBasicKeysTab() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // First row: Essential programming symbols
            _buildCodingKeyButton(
              onPressed: () {
                final offset = widget.codeController.selection.baseOffset;
                widget.codeController.insertStr("\t");
                widget.codeController.setCursor(
                  offset + widget.codeController.params.tabSpaces,
                );
              },
              child: const Text('Tab',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () {
                widget.codeController.insertStr("{}");
                widget.codeController
                    .setCursor(widget.codeController.selection.baseOffset - 1);
              },
              child: const Text('{}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () {
                widget.codeController.insertStr("()");
                widget.codeController
                    .setCursor(widget.codeController.selection.baseOffset - 1);
              },
              child: const Text('()',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () {
                widget.codeController.insertStr("[]");
                widget.codeController
                    .setCursor(widget.codeController.selection.baseOffset - 1);
              },
              child: const Text('[]',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ..._topArrowKeys(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Second row: Common operators
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("|"),
              child: const Text('|',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("&"),
              child: const Text('&',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("_"),
              child: const Text('_',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr(";"),
              child: const Text(';',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ..._bottomArrowKeys(),
          ],
        ),
      ],
    );
  }

  Widget _buildAdvancedKeysTab() {
    return Column(
      children: [
        // Row 1: Additional brackets and quotes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCodingKeyButton(
              onPressed: () {
                widget.codeController.insertStr("<>");
                widget.codeController
                    .setCursor(widget.codeController.selection.baseOffset - 1);
              },
              child: const Text('<>',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () {
                widget.codeController.insertStr('""');
                widget.codeController
                    .setCursor(widget.codeController.selection.baseOffset - 1);
              },
              child: const Text('" "',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () {
                widget.codeController.insertStr("''");
                widget.codeController
                    .setCursor(widget.codeController.selection.baseOffset - 1);
              },
              child: const Text("' '",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("!"),
              child: const Text('!',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("?"),
              child: const Text('?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr(":"),
              child: const Text(':',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("\\"),
              child: const Text('\\',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        // Row 2: Mathematical and logical operators
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("+"),
              child: const Text('+',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("-"),
              child: const Text('-',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("*"),
              child: const Text('*',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("/"),
              child: const Text('/',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("%"),
              child: const Text('%',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("="),
              child: const Text('=',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildCodingKeyButton(
              onPressed: () => widget.codeController.insertStr("^"),
              child: const Text('^',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _topArrowKeys() {
    return [
      _buildCodingKeyButton(
        onPressed: () => widget.codeController.historyController.undo(),
        child: const Icon(
          Icons.undo,
        ),
      ),
      _buildCodingKeyButton(
        onPressed: () => moveCursorToPreviousLineMaintainingColumn(),
        child: const Icon(Icons.arrow_upward),
      ),
      _buildCodingKeyButton(
        onPressed: () => widget.codeController.historyController.redo(),
        child: const Icon(Icons.redo),
      ),
    ];
  }

  List<Widget> _bottomArrowKeys() {
    return [
      _buildCodingKeyButton(
        onPressed: () => widget.codeController.setCursor(
          widget.codeController.selection.baseOffset - 1,
        ),
        child: const Icon(Icons.arrow_back),
      ),
      _buildCodingKeyButton(
        onPressed: () => moveCursorToNextLineMaintainingColumn(),
        child: const Icon(Icons.arrow_downward),
      ),
      _buildCodingKeyButton(
        onPressed: () => widget.codeController.setCursor(
          widget.codeController.selection.baseOffset + 1,
        ),
        child: const Icon(Icons.arrow_forward),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor.withOpacity(0.4),
      height: 78,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBasicKeysTab(),
                _buildAdvancedKeysTab(),
              ],
            ),
          ),
          _buildAnimatedIndicator(),
        ],
      ),
    );
  }

  Widget _buildAnimatedIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: AnimatedBuilder(
        animation: _tabController.animation!,
        builder: (context, child) {
          return SizedBox(
            width: 52,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 2.4,
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset((_tabController.animation!.value * 20), 0),
                    child: Container(
                      height: 2.4,
                      width: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void moveCursorToNextLineMaintainingColumn() {
    final lines = widget.codeController.code.lines.lines;
    final offset = widget.codeController.selection.base.offset;

    final currentLineIndex = lines.indexWhere(
      (line) => offset >= line.textRange.start && offset <= line.textRange.end,
    );

    if (currentLineIndex < lines.length - 1) {
      _calculateNewCursorPosition(lines, currentLineIndex, offset, 1);
    }
  }

  void moveCursorToPreviousLineMaintainingColumn() {
    final lines = widget.codeController.code.lines.lines;
    final offset = widget.codeController.selection.base.offset;

    final currentLineIndex = lines.indexWhere(
      (line) => offset >= line.textRange.start && offset <= line.textRange.end,
    );

    if (currentLineIndex > 0) {
      _calculateNewCursorPosition(lines, currentLineIndex, offset, -1);
    }
  }

  void _calculateNewCursorPosition(
    List<CodeLine> lines,
    int currentLineIndex,
    int offset,
    int lineOffset,
  ) {
    final targetLineIndex = currentLineIndex + lineOffset;
    if (targetLineIndex < 0 || targetLineIndex >= lines.length) {
      return;
    }

    final targetLine = lines[targetLineIndex];
    final currentLine = lines[currentLineIndex];
    final columnOffset = offset - currentLine.textRange.start;
    var newCursorPosition = targetLine.textRange.start + columnOffset;

    if (targetLine.text.isEmpty) {
      newCursorPosition = targetLine.textRange.start;
    } else {
      final lineEndOffset = targetLine.textRange.end;
      newCursorPosition = newCursorPosition.clamp(
        targetLine.textRange.start,
        lineEndOffset,
      );
    }

    widget.codeController.setCursor(newCursorPosition);
  }
}
