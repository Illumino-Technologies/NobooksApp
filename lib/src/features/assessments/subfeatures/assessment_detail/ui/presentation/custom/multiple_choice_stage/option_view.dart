part of 'multiple_choice_stage_view.dart';

class _OptionView extends StatefulWidget {
  final int index;
  final NoteDocument option;
  final bool selected;
  final VoidCallback onChanged;

  const _OptionView({
    Key? key,
    required this.index,
    required this.option,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<_OptionView>
    with IntrinsicCanvasSizeMixin {
  @override
  NoteDocumentController get controller => NoteDocumentController(
        noteDocument: widget.option,
      )..initialize();

  late final bool selected = widget.selected;

  @override
  double get extraWidth => context.screenWidth - 216.w;

  @override
  double get extraHeight => 40.h;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: widget.onChanged,
      child: Row(
        children: [
          Container(
            width: 32.l,
            height: 32.l,
            color: selected ? AppColors.blue500 : null,
            alignment: Alignment.center,
            child: Text(
              Values.upperAlphas[widget.index],
              style: TextStyles.subHeading.copyWith(
                color: selected ? AppColors.white : AppColors.neutral500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          12.boxWidth,
          SizedBox(
            height: 24.h,
            child: VerticalDivider(
              color: selected ? AppColors.blue500 : AppColors.neutral500,
              thickness: 1.w,
              width: 1.w,
            ),
          ),
          12.boxWidth,
          Expanded(
            child: DocumentEditorCanvas(
              readOnly: true,
              canvasSize: canvasSize,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
