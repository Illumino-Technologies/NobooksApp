import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/toolbar_barrel.dart';
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

class ToolBarWidget extends StatefulWidget {
  final ToolbarController controller;

  const ToolBarWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ToolBarWidget> createState() => _ToolBarWidgetState();
}

class _ToolBarWidgetState extends State<ToolBarWidget> {
  final List<ToolBarItem> topItems = ToolBarItem.values.where((element) {
    return element.position == ToolBarItemPosition.top;
  }).toList();

  final List<ToolBarItem> bottomItems = ToolBarItem.values.where((element) {
    return element.position == ToolBarItemPosition.bottom;
  }).toList();

  ToolbarController get controller {
    return widget.controller;
  }

  @override
  void activate() {
    super.activate();
    controller.syncNote();
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
          child: ValueListenableBuilder<DocumentEditorType>(
            valueListenable: documentEditorTypeNotifier,
            builder: (_, documentEditorType, __) {
              return ValueListenableBuilder<List<ToolBarItem>>(
                valueListenable: selectedItemsNotifier,
                builder: (_, selectedItems, __) {
                  return ChangeNotifierBuilder<ToolbarController>(
                    listenable: controller,
                    builder: (_, controllerValue) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          children: [
                            FirstToolbarRow(
                              documentEditorType: documentEditorType,
                              selectedItems: selectedItems,
                              topItems: topItems,
                              onSelected: onSelected,
                              controllerValue: controllerValue,
                            ),
                            11.boxHeight,
                            const Divider(
                              color: AppColors.neutral50,
                              height: 1,
                              thickness: 1,
                            ),
                            11.boxHeight,
                            SecondToolbarRow(
                              documentEditorType: documentEditorType,
                              selectedItems: selectedItems,
                              bottomItems: bottomItems,
                              onSelected: onSelected,
                              controllerValue: controllerValue,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        32.boxWidth,
        Align(
          alignment: Alignment.centerRight,
          child: ValueListenableBuilder<ToolItemSelector>(
            valueListenable: toolItemSelectorNotifier,
            builder: (_, selector, __) {
              switch (selector) {
                case ToolItemSelector.shape:
                  return ShapeSelector(
                    onClose: closeToolItemSelector,
                    shape: controller.drawingController.shape,
                    onChanged: onShapeChanged,
                  );
                case ToolItemSelector.color:
                  return ColorSelector(
                    onClose: closeToolItemSelector,
                    color: controller.color,
                    onChanged: onColorChanged,
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

  final DrawingController newDrawingController = DrawingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.addListener(controllerListener);
    onSelected(ToolBarItem.pen);
  }

  @override
  void didUpdateWidget(covariant ToolBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.syncNote();
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(controllerListener);
      controller.addListener(controllerListener);
    }

    controller.syncNote();
  }

  void changeShapeSelectionByController() {
    final DrawingMode currentDrawingMode =
        controller.drawingController.drawingMode;
    if (currentDrawingMode != DrawingMode.shape &&
        selectedItemsNotifier.value.contains(ToolBarItem.shapes)) {
      selectedItemsNotifier.value = List.from(selectedItemsNotifier.value)
        ..remove(ToolBarItem.shapes);
    }
    if (currentDrawingMode == DrawingMode.shape &&
        !selectedItemsNotifier.value.contains(ToolBarItem.shapes)) {
      selectedItemsNotifier.value = List.from(selectedItemsNotifier.value)
        ..add(ToolBarItem.shapes);
    }
  }

  void controllerListener() {
    if (documentEditorTypeNotifier.value == DocumentEditorType.drawing) {
      changeShapeSelectionByController();
    }
  }

  void closeToolItemSelector() => showSelector(ToolItemSelector.none);

  void redo() {
    controller.redo();
  }

  void undo() {
    controller.undo();
  }

  void showSelector(ToolItemSelector selector) {
    toolItemSelectorNotifier.value = selector;
  }

  void handlePenSelected() {
    documentEditorTypeNotifier.value =
        documentEditorTypeNotifier.value == DocumentEditorType.drawing
            ? () {
                controller.changeCurrentActiveController(
                  controller.textController,
                );
                return DocumentEditorType.text;
              }()
            : () {
                performDrawingAction(ToolBarItem.pen);
                controller.changeCurrentActiveController(
                  controller.drawingController,
                );
                return DocumentEditorType.drawing;
              }();
    clearSelectedItems();
  }

  void handleSelectedItemReselected(ToolBarItem item) {
    if (item == ToolBarItem.shapes &&
        toolItemSelectorNotifier.value == ToolItemSelector.shape) {
      closeToolItemSelector();
    }

    if (DocumentEditorType.drawing.toolBarItems.contains(item)) {
      (item == ToolBarItem.pen &&
              documentEditorTypeNotifier.value == DocumentEditorType.text)
          ? null
          : reverseDrawingAction();
    }

    selectedItemsNotifier.value = List.from(selectedItemsNotifier.value)
      ..remove(item);
  }

  void onSelected(ToolBarItem item) {
    print('item pressed');
    if (item == ToolBarItem.undo) return undo();
    if (item == ToolBarItem.redo) return redo();

    if (item == ToolBarItem.pen) return handlePenSelected();

    if (item == ToolBarItem.color) return showSelector(ToolItemSelector.color);

    if (selectedItemsNotifier.value.contains(item)) {
      handleSelectedItemReselected(item);
      return;
    }

    if (documentEditorTypeNotifier.value == DocumentEditorType.text) {
      return performTextEditingActionOn(item);
    }

    if (item == ToolBarItem.table) {
      documentEditorTypeNotifier.value = DocumentEditorType.table;
      addItemToSelected(item);
      return;
    }
    if (item == ToolBarItem.equation) {
      documentEditorTypeNotifier.value = DocumentEditorType.math;
      addItemToSelected(item);
      return;
    }

    final DocumentEditorType documentType = documentEditorTypeNotifier.value;

    switch (documentType) {
      case DocumentEditorType.general:
        return;
      case DocumentEditorType.drawing:
        {
          performDrawingAction(item);
          continue continuation;
        }
      continuation:
      case DocumentEditorType.math:
      case DocumentEditorType.table:
      case DocumentEditorType.text:
        {
          if (!documentType.toolBarItems.contains(item)) return;
          break;
        }
    }

    addItemToSelected(item);
  }

  void performTextEditingActionOn(ToolBarItem item) {
    print('performTextEditingAction $item');
    switch (item) {
      case ToolBarItem.color:
        // TODO: Handle this case.
        break;
      case ToolBarItem.alignLeft:
        controller.textController.changeAlignment(TextAlign.left);
        break;
      case ToolBarItem.alignCenter:
        controller.textController.changeAlignment(TextAlign.center);
        break;
      case ToolBarItem.alignRight:
        controller.textController.changeAlignment(TextAlign.right);
        break;
      case ToolBarItem.bold:
        controller.textController.toggleBold();
        break;
      case ToolBarItem.italic:
        controller.textController.toggleItalic();
        break;
      case ToolBarItem.underline:
        controller.textController.toggleUnderline();
        break;
      case ToolBarItem.subscript:
        controller.textController.toggleSubscript();
        break;
      case ToolBarItem.superscript:
        controller.textController.toggleSuperscript();
        break;
      case ToolBarItem.roughPaper:
      case ToolBarItem.pen:
      case ToolBarItem.eraser:
      case ToolBarItem.ruler:
      case ToolBarItem.shapes:
      case ToolBarItem.calculator:
      case ToolBarItem.table:
      case ToolBarItem.fourFigTable:
      case ToolBarItem.undo:
      case ToolBarItem.redo:
      case ToolBarItem.equation:
    }
    addItemToSelected(item);
  }

  void onColorChanged(Color color) {
    controller.dispatchColorChange(color);
  }

  void onShapeChanged(Shape shape) {
    controller.drawingController.changeShape(shape);
  }

  void reverseDrawingAction() {
    controller.drawingController.changeDrawingMode(DrawingMode.sketch);
  }

  void addItemToSelected(ToolBarItem item) {
    clearSelectedItems();
    selectedItemsNotifier.value = List.from(selectedItemsNotifier.value)
      ..add(item);
  }

  void clearSelectedItems() {
    final List<ToolBarItem> items = List.from(selectedItemsNotifier.value);
    final List<ToolBarItem> generalItems = items.where((element) {
      return DocumentEditorType.general.toolBarItems.contains(element);
    }).toList();

    items.clear();

    items.addAll(generalItems);
    selectedItemsNotifier.value = generalItems;
  }

  final Map<ToolBarItem, DrawingMode> toolbarItemToDrawingMode = {
    ToolBarItem.pen: DrawingMode.sketch,
    ToolBarItem.eraser: DrawingMode.erase,
    ToolBarItem.shapes: DrawingMode.shape,
    ToolBarItem.ruler: DrawingMode.line,
  };

  final Map<DrawingMode, ToolBarItem> drawingModeToToolbarItem = {
    DrawingMode.sketch: ToolBarItem.pen,
    DrawingMode.erase: ToolBarItem.eraser,
    DrawingMode.shape: ToolBarItem.shapes,
    DrawingMode.line: ToolBarItem.ruler,
  };

  void performDrawingAction(ToolBarItem item) {
    if (toolbarItemToDrawingMode[item] == null) return;
    final DrawingMode drawingAction = toolbarItemToDrawingMode[item]!;
    controller.drawingController.changeDrawingMode(drawingAction);
    if (drawingAction == DrawingMode.shape) {
      showSelector(ToolItemSelector.shape);
    }
  }

  final ValueNotifier<List<ToolBarItem>> selectedItemsNotifier =
      ValueNotifier<List<ToolBarItem>>(
    [],
  );

  final ValueNotifier<DocumentEditorType> documentEditorTypeNotifier =
      ValueNotifier<DocumentEditorType>(
    DocumentEditorType.drawing,
  );

  final ValueNotifier<ToolItemSelector> toolItemSelectorNotifier =
      ValueNotifier<ToolItemSelector>(
    ToolItemSelector.none,
  );

  @override
  void dispose() {
    super.dispose();
    selectedItemsNotifier.dispose();
    toolItemSelectorNotifier.dispose();
    documentEditorTypeNotifier.dispose();
  }
}

enum ToolItemSelector {
  none,
  shape,
  color,
  ;
}
