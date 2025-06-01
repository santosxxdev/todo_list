import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/screens/tasks/task_item.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_list/shared/network/firebase/firebase_manager.dart';

import '../styles/colors.dart';

class TaskTap extends StatefulWidget {
  TaskTap({super.key});

  @override
  State<TaskTap> createState() => _TaskTapState();
}

class _TaskTapState extends State<TaskTap> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: primeColor,
          child: CalendarTimeline(
            key: ValueKey(selectedDate),
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            monthColor: Colors.white,
            dayColor: Colors.white,
            activeDayColor: primeColor,
            leftMargin: 60,
            dotColor: primeColor,
            activeBackgroundDayColor: Colors.white,
            selectableDayPredicate: (date) => true,
            locale: 'en', // لا تستخدم 'en_ISO'
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseManager.getTask(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Someting went Worng'),
                );
              }
              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              // List<TaskModel?> tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]!);
                },
                itemCount: tasks.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
