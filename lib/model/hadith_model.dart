class HadithModel {
  String id;
  String title;
  String text;

//<editor-fold desc="Data Methods">
  HadithModel({
    required this.id,
    required this.title,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HadithModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          text == other.text);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ text.hashCode;

  @override
  String toString() {
    return 'HadithModel{' +
        ' id: $id,' +
        ' title: $title,' +
        ' text: $text,' +
        '}';
  }

  HadithModel copyWith({
    String? id,
    String? title,
    String? text,
  }) {
    return HadithModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'text': this.text,
    };
  }

  factory HadithModel.fromMap(Map<String, dynamic> map) {
    return HadithModel(
      id: map['id'] as String,
      title: map['title'] as String,
      text: map['text'] as String,
    );
  }

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      id: json['id'],
      title: json['title'],
      text: json['text'],
    );
  }

//</editor-fold>
}
