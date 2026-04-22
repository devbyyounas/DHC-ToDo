// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class Todo {
//   String? title;
//   bool? isDone;
//   Todo({
//     this.title,
//     this.isDone,
//   });

//   Todo copyWith({
//     String? title,
//     bool? isDone,
//   }) {
//     return Todo(
//       title: title ?? this.title,
//       isDone: isDone ?? this.isDone,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'title': title,
//       'isDone': isDone,
//     };
//   }

//   factory Todo.fromMap(Map<String, dynamic> map) {
//     return Todo(
//       title: map['title'] != null ? map['title'] as String : null,
//       isDone: map['isDone'] != null ? map['isDone'] as bool : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Todo.fromJson(String source) =>
//       Todo.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Todo(title: $title, isDone: $isDone)';

//   @override
//   bool operator ==(covariant Todo other) {
//     if (identical(this, other)) return true;

//     return other.title == title && other.isDone == isDone;
//   }

//   @override
//   int get hashCode => title.hashCode ^ isDone.hashCode;
// }
class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
      };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}
