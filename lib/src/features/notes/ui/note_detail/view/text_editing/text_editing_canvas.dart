part of '../note_detail_page.dart';

class _TextEditingCanvas extends StatefulWidget {
  const _TextEditingCanvas({Key? key}) : super(key: key);

  @override
  State<_TextEditingCanvas> createState() => _TextEditingCanvasState();
}

class _TextEditingCanvasState extends State<_TextEditingCanvas> {
  
  
  final TextEditingController controller = TextEditingController();
  final RichFieldController _richController = RichFieldController();
  
  @override
  Widget build(BuildContext context) {
    
    
    return Column(
      children: [
        Row(
          children: [
            MaterialButton(
              elevation: 0,
              color: AppColors.subjectDarkOrange.withOpacity(1),
              onPressed: () {},
            ),
            10.boxWidth,
            MaterialButton(
              elevation: 0,
              color: AppColors.subjectOrange.withOpacity(1),
              onPressed: () {},
            ),
            10.boxWidth,
            MaterialButton(
              elevation: 0,
              color: AppColors.subjectBlue.withOpacity(1),
              onPressed: () {},
            ),
            10.boxWidth,
            MaterialButton(
              elevation: 0,
              color: AppColors.subjectWine.withOpacity(1),
              onPressed: () {},
            ),
            10.boxWidth,
            MaterialButton(
              elevation: 0,
              color: AppColors.subjectGreen.withOpacity(1),
              onPressed: () {},
            ),
          ],
        ),
        20.boxHeight,
        20.boxHeight,
        Container(
          color: AppColors.subjectPink,
          height: 400.h,
          child: CustomEditText(

          ),
        ),
      ],
    );
  }
}
