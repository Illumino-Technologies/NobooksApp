part of '../toolbar_widget.dart';

class FirstToolbarRow extends StatelessWidget {
  final DocumentEditorType documentEditorType;
  final List<ToolBarItem> selectedItems;
  final List<ToolBarItem> topItems;
  final ValueChanged<ToolBarItem> onSelected;
  final ToolbarController controllerValue;

  const FirstToolbarRow({
    Key? key,
    required this.documentEditorType,
    required this.selectedItems,
    required this.topItems,
    required this.onSelected,
    required this.controllerValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...topItems.map(
          (item) {
            bool enabled =
                DocumentEditorType.general.toolBarItems.contains(item) ||
                    documentEditorType.toolBarItems.contains(item);

            if (item == ToolBarItem.undo) {
              enabled = controllerValue.canUndo;
            }
            if (item == ToolBarItem.redo) {
              enabled = controllerValue.canRedo;
            }

            final bool selected = selectedItems.contains(item);

            if (item == ToolBarItem.pen) {
              return documentEditorType == DocumentEditorType.text
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
    );
  }
}

class SecondToolbarRow extends StatelessWidget {
  final DocumentEditorType documentEditorType;
  final List<ToolBarItem> selectedItems;
  final List<ToolBarItem> bottomItems;
  final ValueChanged<ToolBarItem> onSelected;
  final ToolbarController controllerValue;

  const SecondToolbarRow({
    Key? key,
    required this.documentEditorType,
    required this.selectedItems,
    required this.bottomItems,
    required this.onSelected,
    required this.controllerValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rough paper: ${controllerValue.showingRoughPaper}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...bottomItems.map(
          (item) {
            bool enabled =
                DocumentEditorType.general.toolBarItems.contains(item) ||
                    documentEditorType.toolBarItems.contains(item);
            if (DocumentEditorType.text.toolBarItems.contains(item)) {
              return TextToolbarButtonItem(
                item: item,
                metadata: controllerValue.textController.metadata ??
                    TextEditorController.defaultMetadata,
                onSelected: onSelected,
                enabled: enabled,
              );
            }
            if (item == ToolBarItem.roughPaper) {
              print(
                'this is where rough paper is and its value is: ${controllerValue.showingRoughPaper}',
              );

              final bool selected = controllerValue.showingRoughPaper;
              final ToolBarItemWidget child = ToolBarItemWidget(
                item: item,
                selected: selected,
                enabled: enabled,
                vectorAsset: item.vectorAssetPath,
              );

              return selected
                  ? MaterialButton(
                      minWidth: 42.h,
                      height: 42.h,
                      color: AppColors.blue400,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: Ui.allBorderRadius(4),
                      ),
                      onPressed: () => onSelected(item),
                      child: child,
                    )
                  : MaterialButton(
                      minWidth: 42.w,
                      height: 42.h,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: Ui.allBorderRadius(4)),
                      onPressed: enabled ? () => onSelected(item) : null,
                      child: child,
                    );
            }
            return ToolbarItemButton(
              item: item,
              enabled: enabled,
              onSelected: onSelected,
              selected: selectedItems.contains(item),
            );
          },
        )
      ],
    );
  }
}
