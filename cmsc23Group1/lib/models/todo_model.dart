

import 'dart:convert';

class Todo {
  final int userId;
  String? uid;
  String? id;
  String title;
  bool completed;

  Todo({
    required this.userId,
    this.uid,
    this.id,
    required this.title,
    required this.completed,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      uid: json['uid'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      'userId': todo.userId,
      'uid': todo.uid,
      'title': todo.title,
      'completed': todo.completed,
    };
  }
}
