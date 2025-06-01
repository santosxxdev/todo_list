import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/shared/network/firebase/firebase_manager.dart';
import 'package:todo_list/styles/colors.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatefulWidget {
  EditScreen(this.taskModel);

  TaskModel taskModel;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var tasknameController = TextEditingController();
  var taskdecController = TextEditingController();
  var dateTask;

  void initState() {
    super.initState();
    tasknameController = TextEditingController(text: widget.taskModel.titel);
    taskdecController =
        TextEditingController(text: widget.taskModel.discrapion);
    dateTask = DateTime.fromMicrosecondsSinceEpoch(widget.taskModel.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primeColor,
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Edit Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: tasknameController,
                    decoration: InputDecoration(
                      hintText: "TaskName",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primeColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primeColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: taskdecController,
                    decoration: InputDecoration(
                      hintText: "Details Task",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primeColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primeColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Select Time :',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: dateTask,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              dateTask = selectedDate;
                            });
                          }
                        },
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(dateTask),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseManager.updateData(
                          widget.taskModel.id,
                          taskdecController.text,
                          tasknameController.text,
                          DateUtils.dateOnly(dateTask).microsecondsSinceEpoch,
                        ).then((value) {
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primeColor,
                          foregroundColor: Colors.white,
                          minimumSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Save Changes',
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
