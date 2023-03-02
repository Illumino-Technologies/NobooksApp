import 'package:flutter/material.dart';

// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/features_barrel.dart'
    show Note, NoteDetailPage;

class NoteDetailPage extends ConsumerStatefulWidget {
  final Note note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(),
    );
  }
}
