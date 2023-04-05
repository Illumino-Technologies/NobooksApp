part of '../note_detail_page.dart';

class _TextEditingCanvas extends StatefulWidget {
  const _TextEditingCanvas({Key? key}) : super(key: key);

  @override
  State<_TextEditingCanvas> createState() => _TextEditingCanvasState();
}

class _TextEditingCanvasState extends State<_TextEditingCanvas> {
  final TextEditingController controller = TextEditingController();
  final RichFieldController _richController = RichFieldController();
  final TextEditorController myController = TextEditorController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      child: Column(
        children: [
          Row(
            children: [
              MaterialButton(
                elevation: 0,
                color: AppColors.subjectDarkOrange.withOpacity(1),
                onPressed: () {
                  myController.toggleBold();
                },
                child: const Text("bold"),
              ),
              10.boxWidth,
              MaterialButton(
                elevation: 0,
                color: AppColors.subjectOrange.withOpacity(1),
                child: const Text("underline"),
                onPressed: () {
                  myController.toggleUnderline();
                },
              ),
              10.boxWidth,
              MaterialButton(
                elevation: 0,
                color: AppColors.subjectBlue.withOpacity(1),
                child: const Text("align left"),
                onPressed: () {
                  myController.changeAlignment(TextAlign.left);
                },
              ),
              10.boxWidth,
              MaterialButton(
                elevation: 0,
                color: AppColors.subjectWine.withOpacity(1),
                child: const Text("align right"),
                onPressed: () {
                  myController.changeAlignment(TextAlign.right);
                },
              ),
              10.boxWidth,
              MaterialButton(
                elevation: 0,
                color: AppColors.subjectGreen.withOpacity(1),
                onPressed: () {
                  myController.changeAlignment(TextAlign.center);
                },
                child: const Text("align center"),
              ),
              10.boxWidth,
              MaterialButton(
                elevation: 0,
                color: AppColors.subjectGreen.withOpacity(1),
                onPressed: () {
                  myController.toggleItalic();
                },
                child: const Text("Italicize"),
              ),
            ],
          ),
          20.boxHeight,
          20.boxHeight,
          SizedBox(
            height: 300,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: myController,
              builder: (_, controllerValue, __) {
                return TextField(
                  textAlign:
                      myController.metadata?.alignment ?? TextAlign.start,
                  style: TextEditorController.defaultMetadata.style,
                  controller: myController,
                  maxLines: null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
