import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class RoughPaper extends StatefulWidget {
  final VoidCallback onClose;
  final Size size;

  const RoughPaper({
    Key? key,
    required this.size,
    required this.onClose,
  }) : super(key: key);

  @override
  State<RoughPaper> createState() => _RoughPaperState();
}

class _RoughPaperState extends State<RoughPaper> {
  final DrawingController controller = DrawingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.initialize(
      sketchMetadata: const DrawingMetadata(
        color: AppColors.black,
        strokeWidth: 2,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: widget.onClose,
          icon: Icon(
            Icons.close,
            color: AppColors.neutral400,
            size: 24.r,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.paper,
            border: Border.all(
              color: AppColors.neutral200,
              width: 1,
            ),
            borderRadius: Ui.allBorderRadius(8.r),
          ),
          height: widget.size.height,
          width: widget.size.width,
          child: DrawingCanvas(
            controller: controller,
            size: widget.size,
          ),
        ),
      ],
    );
  }
}
