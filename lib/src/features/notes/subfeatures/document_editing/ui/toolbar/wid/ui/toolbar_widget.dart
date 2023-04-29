import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/ioc/toolbar_inherited_widget.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/toolbar_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/wid/state_mgmt/toolbar_state_notifier.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/color_wheel_dialog.dart';

part 'custom/extracted_widgets.dart';

part 'custom/hue_slider.dart';

part 'custom/knob.dart';

part 'custom/main_color_slider.dart';

part 'custom/shape_selector_dialog.dart';

part 'custom/text_toolbar_item_widget.dart';

part 'custom/tool_bar_item_widget.dart';

part 'custom/toolbar_item_button.dart';

part 'custom/transparency_slider.dart';

class NewToolBarWidget extends StatefulWidget {
  const NewToolBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NewToolBarWidget> createState() => _NewToolBarWidgetState();
}

class _NewToolBarWidgetState extends State<NewToolBarWidget> {
  final List<ToolBarItem> topItems = ToolBarItem.values.where((element) {
    return element.position == ToolBarItemPosition.top;
  }).toList();

  final List<ToolBarItem> bottomItems = ToolBarItem.values.where((element) {
    return element.position == ToolBarItemPosition.bottom;
  }).toList();

  late final ToolbarStateNotifier toolbarNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    toolbarNotifier = ToolbarStateNotifier(
      controller: NoteDocumentContainer.of(context)!.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 902.w,
          // height: 128.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: Ui.allBorderRadius(8),
          ),
          child: ValueListenableBuilder<ToolbarState>(
            valueListenable: toolbarNotifier,
            builder: (_, toolbarState, __) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
                child: Column(
                  children: [
                    FirstToolbarRow(
                      documentEditorType: toolbarState.currentDocumentType,
                      selectedItems: toolbarState.selectedItems,
                      topItems: topItems,
                      onSelected: toolbarNotifier.onSelected,
                      controllerValue:
                          NoteDocumentContainer.of(context)!.controller,
                    ),
                    11.boxHeight,
                    const Divider(
                      color: AppColors.neutral50,
                      height: 1,
                      thickness: 1,
                    ),
                    11.boxHeight,
                    SecondToolbarRow(
                      documentEditorType: toolbarState.currentDocumentType,
                      selectedItems: toolbarState.selectedItems,
                      bottomItems: bottomItems,
                      onSelected: toolbarNotifier.onSelected,
                      controllerValue:
                          NoteDocumentContainer.of(context)!.controller,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        32.boxWidth,
        Align(
          alignment: Alignment.centerRight,
          child: ValueListenableSelector<ToolbarState>(
            listenable: toolbarNotifier,
            buildWhen: (previous, current) =>
                previous?.selector != current.selector,
            builder: (_, toolbarState) {
              switch (toolbarState.selector) {
                case ToolItemSelector.shape:
                  return ShapeSelector(
                    onClose: toolbarNotifier.closeToolItemSelector,
                    shape: NoteDocumentContainer.of(context)!
                        .controller
                        .drawingController
                        .shape,
                    onChanged: NoteDocumentContainer.of(context)!
                        .controller
                        .drawingController
                        .changeShape,
                  );
                case ToolItemSelector.color:
                  return ColorSelector(
                    onClose: toolbarNotifier.closeToolItemSelector,
                    color: NoteDocumentContainer.of(context)!.controller.color,
                    onChanged: NoteDocumentContainer.of(context)!
                        .controller
                        .dispatchColorChange,
                  );
                case ToolItemSelector.none:
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    toolbarNotifier.dispose();
    super.dispose();
  }
}
