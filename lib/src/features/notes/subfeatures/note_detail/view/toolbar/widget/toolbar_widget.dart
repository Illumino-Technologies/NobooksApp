import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/features/notes/subfeatures/note_detail/view/toolbar/toolbar_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/constants/assets/assets.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

import '../../../../document_editing/drawing/drawing_barrel.dart';

part 'custom/tool_bar_item_widget.dart';

part 'custom/toolbar_item_button.dart';

class ToolBarWidget extends StatefulWidget {
  const ToolBarWidget({
    Key? key,
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

  // ToolbarController get controller {}

  @override
  Widget build(BuildContext context) {
    return Container(
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...topItems.map(
                          (item) {
                            final bool enabled = DocumentEditorType
                                    .general.toolBarItems
                                    .contains(item) ||
                                documentEditorType.toolBarItems.contains(item);
                            final bool selected = selectedItems.contains(item);

                            if (item == ToolBarItem.pen) {
                              return documentEditorType ==
                                      DocumentEditorType.text
                                  ? ToolbarItemButton(
                                      item: item,
                                      selected: selected,
                                      enabled: enabled,
                                      vectorAssetPath: VectorAssets.textIcon,
                                      onSelected: onSelected,
                                    )
                                  : ToolbarItemButton(
                                      item: item,
                                      selected: selected,
                                      enabled: enabled,
                                      vectorAssetPath: VectorAssets.penIcon,
                                      onSelected: onSelected,
                                    );
                            }

                            return ToolbarItemButton(
                              item: item,
                              enabled: enabled,
                              onSelected: onSelected,
                              selected: selected,
                            );
                          },
                        )
                      ],
                    ),
                    11.boxHeight,
                    const Divider(
                      color: AppColors.neutral50,
                      height: 1,
                      thickness: 1,
                    ),
                    11.boxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...bottomItems.map(
                          (item) => ToolbarItemButton(
                            item: item,
                            enabled: DocumentEditorType.general.toolBarItems
                                    .contains(item) ||
                                documentEditorType.toolBarItems.contains(item),
                            onSelected: onSelected,
                            selected: selectedItems.contains(item),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void redo() {}

  void undo() {}

  void onSelected(ToolBarItem item) {
    if (item == ToolBarItem.undo) return undo();
    if (item == ToolBarItem.redo) return redo();

    if (item == ToolBarItem.pen) {
      documentEditorTypeNotifier.value =
          documentEditorTypeNotifier.value == DocumentEditorType.drawing
              ? DocumentEditorType.text
              : DocumentEditorType.drawing;
      clearSelectedItems();
      return;
    }

    if (selectedItemsNotifier.value.contains(item)) {
      selectedItemsNotifier.value = List.from(selectedItemsNotifier.value)
        ..remove(item);
      return;
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

  void performDrawingAction(ToolBarItem item) {
    if (toolbarItemToDrawingMode[item] == null) return;
    // controller.drawingController.changeDrawingMode(
    //   toolbarItemToDrawingMode[item]!,
    // );
  }

  final ValueNotifier<List<ToolBarItem>> selectedItemsNotifier =
      ValueNotifier<List<ToolBarItem>>(
    [],
  );

  Future showDialogPop() async {
    // showDialog(context: context, builder: builder )
  }

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

class ShapeSelector extends StatelessWidget {
  const ShapeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
