import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuthAPI _authAPI = FirebaseAuthAPI();

  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      final docRef = await db.collection("todos").add(todo);
      await db.collection("todos").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllTodos() {
    String? uid = _authAPI.getUserUID();
    return db.collection("todos").where("uid", isEqualTo: uid).snapshots();
    // return db.collection("todos").snapshots();
  }

  Future<String> deleteTodo(String? id) async {
    try {
      await db.collection("todos").doc(id).delete();

      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editTodo(String? id, String newTask) async{
    try {
      await db.collection("todos").doc(id).update({"title" : newTask});

      return "Successfully edited todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> toggleStatus(int index, bool value, String? taskID) async{
    try {
      await db.collection("todos").doc(taskID).update({"completed":value}); //update toggle status in firebase
      return "Succesfully toggled task!";
    } on FirebaseException catch (e){
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
