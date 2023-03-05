import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:nobook/src/global/global_barrel.dart';

class PainterWidgetView extends StatefulWidget {
  const PainterWidgetView({Key? key}) : super(key: key);

  @override
  State<PainterWidgetView> createState() => _PainterWidgetViewState();
}

class _PainterWidgetViewState extends State<PainterWidgetView> {
  late final PainterController controller = PainterController(
    settings: const PainterSettings(
      freeStyle: FreeStyleSettings(
        strokeWidth: 2,
        color: AppColors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.subjectPink,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            color: AppColors.green50,
            onPressed: () {
              controller.freeStyleMode = FreeStyleMode.erase;
              controller.freeStyleStrokeWidth = 4;
              // controller.clearDrawables();
            },
          ),
          FlutterPainter.builder(
            controller: controller,
            builder: (context, painter) {
              return SizedBox.square(
                dimension: 600,
                child: painter,
              );
            },
          ),
        ],
      ),
    );
  }
}
