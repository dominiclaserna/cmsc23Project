
import 'package:flutter/material.dart';
import '../api/firebase_todo_api.dart';
import '../models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;
  Todo? _selectedTodo;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todos => _todosStream;
  Todo get selected => _selectedTodo!;

  changeSelectedTodo(Todo item) {
    _selectedTodo = item;
  }

  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  void editTodo(String newTitle) async {
    String message = await firebaseService.editTodo(_selectedTodo!.id, newTitle);
    notifyListeners();
  }

  void deleteTodo() async {
    String message = await firebaseService.deleteTodo(_selectedTodo!.id);
    notifyListeners();
  }

  void toggleStatus(int index, bool status, String? taskID) async {
    // _todoList[index].completed = status;
    String message = await firebaseService.toggleStatus(index, status, taskID);
    notifyListeners();
  }
  
}
