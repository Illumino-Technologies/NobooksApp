class NoteModel {
  int? id;
  String title;
  String content;
  String noteColor;

  NoteModel({
    this.id,
    this.title = "Note",
    this.content = "Text",
    this.noteColor = 'red',
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['title'] = title;
    data['content'] = content;
    data['noteColor'] = noteColor;
    return data;
  }

  @override
  toString() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'noteColor': noteColor,
    }.toString();
  }
}
