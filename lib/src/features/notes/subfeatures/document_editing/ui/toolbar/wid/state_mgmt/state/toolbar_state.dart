part of '../toolbar_state_notifier.dart';

class ToolbarState {
  final List<ToolBarItem> selectedItems;
  final DocumentEditorType currentDocumentType;
  final ToolItemSelector selector;

  const ToolbarState({
    this.selector = ToolItemSelector.none,
    required this.selectedItems,
    required this.currentDocumentType,
  });

  ToolbarState copyWith({
    List<ToolBarItem>? selectedItems,
    DocumentEditorType? currentDocumentType,
    ToolItemSelector? selector,
  }) {
    return ToolbarState(
      selector: selector ?? this.selector,
      selectedItems: selectedItems ?? this.selectedItems,
      currentDocumentType: currentDocumentType ?? this.currentDocumentType,
    );
  }

  void addItem(ToolBarItem item) {
    if (selectedItems.contains(item)) return;
    selectedItems.add(item);
  }

  void removeItem(ToolBarItem item) {
    if (!selectedItems.contains(item)) return;
    selectedItems.remove(item);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolbarState &&
          runtimeType == other.runtimeType &&
          selectedItems == other.selectedItems &&
          selector == other.selector;

  @override
  int get hashCode =>
      selectedItems.hashCode ^ currentDocumentType.hashCode ^ selector.hashCode;
}
