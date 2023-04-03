import 'package:equatable/equatable.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/subfeatures/text_editor/models/text_editor_models_barrel.dart';

class TextDelta extends Equatable {
  final String char;
  final TextMetadata? metadata;

  const TextDelta({
    required this.char,
    this.metadata,
  });

  @override
  List<Object?> get props => [char, metadata];

  TextDelta copyWith({
    String? char,
    TextMetadata? metadata,
  }) {
    return TextDelta(
      char: char ?? this.char,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'char': char,
      'metadata': metadata?.toMap(),
    };
  }

  factory TextDelta.fromMap(Map<String, dynamic> map) {
    return TextDelta(
      char: map['char'] as String,
      metadata: map['metadata'] == null
          ? null
          : TextMetadata.fromMap(map['metadata']),
    );
  }
}
