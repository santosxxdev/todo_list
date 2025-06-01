import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/screens/edit_screen.dart';
import 'package:todo_list/shared/network/firebase/firebase_manager.dart';

import '../../styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseManager.deleteTask(taskModel.id);

            },
            backgroundColor: Colors.red,
            label: "Delete",
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditScreen(taskModel);
              },));
            },
            backgroundColor: Colors.blue,
            label: "Edit",
            icon: Icons.edit,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 4,
                margin: EdgeInsets.only(left: 5, right: 10),
                decoration: BoxDecoration(
                  color: primeColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: primeColor),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.titel,
                    style: TextStyle(
                      fontSize: 24,
                      color: primeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          taskModel.discrapion,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  if(taskModel.isDone== true ){
                    FirebaseManager.updateTask(taskModel.id, false);
                  }else{
                    FirebaseManager.updateTask(taskModel.id, true);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: checkItemDone(),
                  ),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color checkItemDone() {
    if (taskModel.isDone == true) {
      return Colors.green;
    }
    return primeColor;
  }
}
