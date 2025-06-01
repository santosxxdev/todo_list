import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance.collection('Tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task){
    var colection = getTaskCollection();
    var docRef = colection.doc();
    task.id=docRef.id;
    return docRef.set(task);

  }


  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date){
     return getTaskCollection().where("date",isEqualTo: DateUtils.dateOnly(date).microsecondsSinceEpoch).snapshots();
  }

  static Future<void> deleteTask(String taskId){
    return getTaskCollection().doc(taskId).delete();
  }

  static void updateTask(String taskId, bool isDone){

    getTaskCollection().doc(taskId).update({"isDone" : isDone});
  }

  static Future<void> updateData(String taskId, String discrapion, String titel , int date){

    return getTaskCollection().doc(taskId).update({"discrapion" : discrapion , "titel" : titel , "date": date });
  }

}
