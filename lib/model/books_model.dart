class BooksModel {
  String title;
  String description;
  String author;
  int id;

//<editor-fold desc="Data Methods">
  BooksModel({
    required this.title,
    required this.description,
    required this.author,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BooksModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          author == other.author &&
          id == other.id);

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ author.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'BooksModel{' +
        ' title: $title,' +
        ' description: $description,' +
        ' author: $author,' +
        ' id: $id,' +
        '}';
  }

  BooksModel copyWith({
    String? title,
    String? description,
    String? author,
    int? id,
  }) {
    return BooksModel(
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'author': this.author,
      'id': this.id,
    };
  }

  factory BooksModel.fromMap(Map<String, dynamic> map) {
    return BooksModel(
      title: map['title'] as String,
      description: map['description'] as String,
      author: map['author'] as String,
      id: map['id'] as int,
    );
  }

//</editor-fold>
}
