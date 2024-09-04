import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
   int? id;
   String title;
   String body;
   DateTime dateTime;
  NoteModel({
    required this.title,
    required this.body,
    required this.dateTime,
    this.id,
  });


  NoteModel copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? dateTime,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel( title: $title, body: $body, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return 
      title.hashCode ^
      body.hashCode ^
      dateTime.hashCode;
  }
}
