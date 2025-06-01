import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/shared/network/firebase/firebase_manager.dart';
import 'package:todo_list/styles/colors.dart';

class AddButtonSheet extends StatefulWidget {
  AddButtonSheet({super.key});

  @override
  State<AddButtonSheet> createState() => _AddButtonSheetState();
}

class _AddButtonSheetState extends State<AddButtonSheet> {
  var titleController = TextEditingController();
  var desController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 21,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text('Name Task'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeColor)),
              )),
          SizedBox(
            height: 20,
          ),
          TextField(
              controller: desController,
              decoration: InputDecoration(
                label: Text('Task Description'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primeColor)),
              )),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                'Select Data',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                  onTap: () {
                    SelectDataDay();
                  },
                  child: Text(
                    selectedDate.toString().substring(0,10),
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              TaskModel task = TaskModel(titel: titleController.text, discrapion: desController.text, date: DateUtils.dateOnly(selectedDate).microsecondsSinceEpoch);
              FirebaseManager.addTask(task).then((value) {
                Navigator.pop(context);
              },);


            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: primeColor,
                minimumSize: Size(250, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.white))),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  SelectDataDay() async {
    DateTime? chosenTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate= chosenTime!;
    setState(() {

    });
  }
}
