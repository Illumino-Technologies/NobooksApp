import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart' show Note;
import 'package:nobook/src/features/notes/domain/sync_logic/note_sync_logic.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/ioc/toolbar_inherited_widget.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return true ? NoteDetailPageX(note: note) : Container();
  }
}

class NoteDetailPageX extends ConsumerStatefulWidget {
  final Note note;

  const NoteDetailPageX({
    super.key,
    required this.note,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NoteDetailPageX> {
  final double drawingBoundsVertical = 500;
  final double drawingBoundsHorizontal = 600;

  @override
  Widget build(BuildContext context) {
    return NoteDocumentContainer(
      controller: documentController,
      child: Material(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    20.boxHeight,
                    ToolBarWidget(controller: documentController),
                    20.boxHeight,
                    MaterialButton(
                      onPressed: () {
                        NoteSyncLogic(
                          currentNote: widget.note.copyWith(
                            noteBody: documentController.noteDocument,
                          ),
                        ).clearNotes();

                        documentController.clear();
                      },
                      child: const Icon(Icons.delete),
                    ),
                    20.boxHeight,
                    DocumentEditorCanvas(
                      canvasSize: Size(900.w, 546.h),
                      controller: documentController,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 32.w),
              alignment: Alignment.centerRight,
              child: ChangeNotifierBuilder<NoteDocumentController>(
                listenable: documentController,
                builder: (_, controllerValue) {
                  return controllerValue.showingRoughPaper
                      ? RoughPaper(
                          onClose: () => controllerValue.toggleRoughPaper(
                            false,
                          ),
                          size: Size(400.w, 528.h),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  late final NoteSyncLogic noteSyncLogic = NoteSyncLogic(
    currentNote: widget.note,
  );

  final ValueNotifier<bool> erasingNotifier = ValueNotifier<bool>(false);

  @override
  void activate() {
    super.activate();
    syncNote();
  }

  @override
  void didUpdateWidget(covariant NoteDetailPageX oldWidget) {
    super.didUpdateWidget(oldWidget);
    syncNote();
  }

  Future<void> syncNote() async {
    await noteSyncLogic.syncNote(
      widget.note.copyWith(
        noteBody: documentController.noteDocument,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> initializeNoteEditor() async {
    final Note? cachedNote = await noteSyncLogic.fetchStoredNote();
    if (cachedNote == null) return;
    documentController.initialize(noteDocument: cachedNote.noteBody);
  }

  late final NoteDocumentController documentController = NoteDocumentController(
    noteDocument: widget.note.noteBody,
  );

  @override
  void initState() {
    super.initState();
    documentController.initialize();
    initializeNoteEditor();
  }

  @override
  void dispose() {
    syncNote();
    erasingNotifier.dispose();
    documentController.dispose();

    super.dispose();
  }
}
