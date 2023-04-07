part of '../toolbar_widget.dart';

class TextToolbarButtonItem extends StatelessWidget {
  final ToolBarItem item;
  final TextMetadata metadata;
  final bool enabled;
  final String? vectorAssetPath;
  final ValueChanged<ToolBarItem> onSelected;

  const TextToolbarButtonItem({
    Key? key,
    required this.item,
    required this.metadata,
    required this.onSelected,
    required this.enabled,
    this.vectorAssetPath,
  }) : super(key: key);

  void onPressed() => onSelected(item);

  @override
  Widget build(BuildContext context) {
    late bool selected;

    switch (item) {
      case (ToolBarItem.bold):
        selected = metadata.fontWeight == FontWeight.w700;
        break;
      case ToolBarItem.alignLeft:
        selected = metadata.alignment == TextAlign.left ||
            metadata.alignment == TextAlign.start;
        break;
      case ToolBarItem.alignCenter:
        selected = metadata.alignment == TextAlign.center;
        break;
      case ToolBarItem.alignRight:
        selected = metadata.alignment == TextAlign.right ||
            metadata.alignment == TextAlign.end;
        break;
      case ToolBarItem.italic:
        selected = metadata.fontStyle == FontStyle.italic;
        break;
      case ToolBarItem.underline:
        selected = metadata.decoration == TextDecorationEnum.underline;
        break;
      case ToolBarItem.subscript:
        selected = metadata.fontFeatures?.firstOrNull ==
            const FontFeature.subscripts();
        break;
      case ToolBarItem.superscript:
        selected = metadata.fontFeatures?.firstOrNull ==
            const FontFeature.superscripts();
        break;
      default:
        selected = false;
        break;
    }

    selected = selected && enabled;

    final ToolBarItemWidget child = ToolBarItemWidget(
      item: item,
      selected: selected,
      enabled: enabled,
      vectorAsset: vectorAssetPath,
    );

    return selected
        ? MaterialButton(
            minWidth: 42.h,
            height: 42.h,
            color: AppColors.blue400,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: Ui.allBorderRadius(4)),
            onPressed: onPressed,
            child: child,
          )
        : MaterialButton(
            minWidth: 42.w,
            height: 42.h,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: Ui.allBorderRadius(4)),
            onPressed: enabled ? onPressed : null,
            child: child,
          );
  }
}
