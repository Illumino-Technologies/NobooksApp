import 'package:flutter/material.dart';

class ListenableBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final Listenable listenable;

  const ListenableBuilder({
    Key? key,
    required this.builder,
    required this.listenable,
  }) : super(key: key);

  @override
  State<ListenableBuilder> createState() => _ListenableBuilderState();
}

class _ListenableBuilderState extends State<ListenableBuilder> {
  void _listener() => setState(() {});

  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_listener);
  }

  @override
  void didUpdateWidget(covariant ListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listenable != widget.listenable) {
      oldWidget.listenable.removeListener(_listener);
      widget.listenable.addListener(_listener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.listenable.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
