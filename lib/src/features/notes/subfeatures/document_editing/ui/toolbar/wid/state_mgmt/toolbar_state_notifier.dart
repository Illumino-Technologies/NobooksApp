import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';

part 'state/toolbar_state.dart';

class ToolbarStateNotifier extends ValueNotifier<ToolbarState> {
  final NoteDocumentController controller;

  ToolbarStateNotifier({
    required this.controller,
    ToolbarState? state,
  }) : super(
          state ??
              const ToolbarState(
                selectedItems: [],
                currentDocumentType: DocumentEditorType.drawing,
              ),
        );

  void closeToolItemSelector() {
    value = value.copyWith(selector: ToolItemSelector.none);
  }

  void onSelected(ToolBarItem item) => _onSelectedDelegate(
        item,
        !value.selectedItems.contains(item),
      );

  void _onPenSelected(bool itemAdded) {}

  void _onSelectedDelegate(ToolBarItem item, bool itemAdded) {
    if (itemAdded) {
      value = value.copyWith()..removeItem(item);
    } else {
      value = value.copyWith()..addItem(item);
    }

    if (item == ToolBarItem.shapes) return _onShapeSelected(itemAdded);
    if (item == ToolBarItem.roughPaper) return _onRoughPaperSelected(itemAdded);
    if (item == ToolBarItem.color) return _onColorSelected(itemAdded);
    if (item == ToolBarItem.undo) return _onUndoSelected(itemAdded);
    if (item == ToolBarItem.redo) return _onRedoSelected(itemAdded);
    if (item == ToolBarItem.eraser) return _onEraserSelected(itemAdded);
    if (item == ToolBarItem.pen) return _onPenSelected(itemAdded);
    if (DocumentEditorType.text.toolBarItems.contains(item)) {
      return _textSelectedDelegate(item, itemAdded);
    }
  }

  void _textSelectedDelegate(ToolBarItem item, bool itemAdded) {}

  void _onShapeSelected(bool itemAdded) {
    if (itemAdded) {
      value = value.copyWith(
        selector: ToolItemSelector.shape,
      );
      controller.drawingController.changeDrawingMode(DrawingMode.shape);
      return;
    }
    value = value.copyWith(
      selector: value.selector == ToolItemSelector.shape
          ? ToolItemSelector.none
          : value.selector,
    );
    controller.drawingController.changeDrawingModeToPrevious(DrawingMode.shape);
  }

  void _onEraserSelected(bool itemAdded) {
    if (itemAdded) {
      value = value.copyWith(
        selectedItems: value.selectedItems..add(ToolBarItem.eraser),
      );
      controller.drawingController.toggleErase();
      return;
    }
    value = value.copyWith(
      selectedItems: value.selectedItems..remove(ToolBarItem.eraser),
    );

    //action
    controller.drawingController.toggleErase();
  }

  void _onColorSelected(bool itemAdded) {
    if (itemAdded) {
      value = value.copyWith(
        selector: ToolItemSelector.color,
      );
      return;
    }
    value = value.copyWith(
      selector: value.selector == ToolItemSelector.color
          ? ToolItemSelector.none
          : value.selector,
    );
  }

  void _onUndoSelected(bool itemAdded) {
    controller.undo();
  }

  void _onRedoSelected(bool itemAdded) {
    controller.redo();
  }

  void _onRoughPaperSelected(bool itemAdded) {
    controller.toggleRoughPaper();
  }
}
