import 'package:flutter/material.dart';


class ToolBarWidget extends StatefulWidget {
  const ToolBarWidget({Key? key}) : super(key: key);

  @override
  State<ToolBarWidget> createState() => _ToolBarWidgetState();
}

class _ToolBarWidgetState extends State<ToolBarWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


enum ToolBarItem {
  pen, eraser, ruler, shapes, calculator, table, fourFigTable, undo, redo,
  alignLeft, alignCenter, alignRight, bold, italic, underline, color,
}

enum ToolBarItemPosition {
  top,
  bottom,
}