import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/drawing/drawing_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/text_editor_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/ui/toolbar/toolbar_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/color_selector.dart';

part 'custom/extracted_widgets.dart';

part 'custom/selector_overlay.dart';

part 'custom/shape_selector_dialog.dart';

part 'custom/text_toolbar_item_widget.dart';

part 'custom/tool_bar_item_widget.dart';

part 'custom/toolbar_item_button.dart';

class ToolBarWidget extends StatefulWidget {
  final NoteDocumentController controller;

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

  NoteDocumentController get controller {
    return widget.controller;
  }

  @override
  void activate() {
    super.activate();
    syncNote();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
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
                return ChangeNotifierBuilder<NoteDocumentController>(
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
    syncNote();
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(controllerListener);
      controller.addListener(controllerListener);
    }

    syncNote();
  }

  void syncNote() {}

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

  OverlayEntry? selectorEntry;

  void showSelector(ToolItemSelector selector) {
    if (selectorEntry != null) removeOverlayEntry();

    if (selector == ToolItemSelector.none) return removeOverlayEntry();

    selectorEntry = OverlayEntry(
      builder: (context) => SelectorOverlay(
        builder: (context) {
          return switch (selector) {
            ToolItemSelector.color => ColorSelector(
                onClose: () {
                  if (selectedItemsNotifier.value.contains(ToolBarItem.color)) {
                    selectedItemsNotifier.value =
                        List.from(selectedItemsNotifier.value)
                          ..remove(ToolBarItem.color);
                  }
                  removeOverlayEntry();
                },
                color: controller.color,
                onChanged: onColorChanged,
              ),
            ToolItemSelector.shape => ShapeSelector(
                onClose: () {
                  if (selectedItemsNotifier.value
                      .contains(ToolBarItem.shapes)) {
                    selectedItemsNotifier.value =
                        List.from(selectedItemsNotifier.value)
                          ..remove(ToolBarItem.shapes);
                  }
                  removeOverlayEntry();
                },
                shape: controller.drawingController.shape,
                onChanged: onShapeChanged,
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
    Overlay.of(context).insert(selectorEntry!);
  }

  void removeOverlayEntry() {
    selectorEntry?.remove();
    selectorEntry = null;
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
    if (item == ToolBarItem.color || item == ToolBarItem.shapes) {
      removeOverlayEntry();
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
    if (item == ToolBarItem.undo) return undo();
    if (item == ToolBarItem.redo) return redo();

    if (item == ToolBarItem.pen) return handlePenSelected();

    if (documentEditorTypeNotifier.value == DocumentEditorType.text &&
        DocumentEditorType.text.toolBarItems.contains(item)) {
      return performTextEditingActionOn(item);
    }

    if (item == ToolBarItem.roughPaper) return controller.toggleRoughPaper();

    if (selectedItemsNotifier.value.contains(item)) {
      handleSelectedItemReselected(item);
      return;
    }
    if (item == ToolBarItem.color) showSelector(ToolItemSelector.color);

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
        performDrawingAction(item);
        continue continuation;
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

  @override
  void dispose() {
    super.dispose();
    selectedItemsNotifier.dispose();
    documentEditorTypeNotifier.dispose();
  }
}
