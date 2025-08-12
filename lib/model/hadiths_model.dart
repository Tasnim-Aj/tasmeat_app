import 'dart:core';

class HadithsModel {
  final String title;
  final String content;
  final String raawi;
  final int id;
  final int book_id;

//<editor-fold desc="Data Methods">
  const HadithsModel({
    required this.title,
    required this.content,
    required this.raawi,
    required this.id,
    required this.book_id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HadithsModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          content == other.content &&
          raawi == other.raawi &&
          id == other.id &&
          book_id == other.book_id);

  @override
  int get hashCode =>
      title.hashCode ^
      content.hashCode ^
      raawi.hashCode ^
      id.hashCode ^
      book_id.hashCode;

  @override
  String toString() {
    return 'HadithsModel{' +
        ' title: $title,' +
        ' content: $content,' +
        ' raawi: $raawi,' +
        ' id: $id,' +
        ' book_id: $book_id,' +
        '}';
  }

  HadithsModel copyWith({
    String? title,
    String? content,
    String? raawi,
    int? id,
    int? book_id,
  }) {
    return HadithsModel(
      title: title ?? this.title,
      content: content ?? this.content,
      raawi: raawi ?? this.raawi,
      id: id ?? this.id,
      book_id: book_id ?? this.book_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'content': this.content,
      'raawi': this.raawi,
      'id': this.id,
      'book_id': this.book_id,
    };
  }

  factory HadithsModel.fromMap(Map<String, dynamic> map) {
    return HadithsModel(
      title: map['title'] as String,
      content: map['content'] as String,
      raawi: map['raawi'] as String,
      id: map['id'] as int,
      book_id: map['book_id'] as int,
    );
  }

//</editor-fold>
}
