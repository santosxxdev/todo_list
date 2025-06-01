import 'package:flutter/material.dart';

import '../screens/setting_screen.dart';
import '../screens/taskTap.dart';
import '../screens/tasks/add_button_sheet.dart';
import '../styles/colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routname = "homeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [TaskTap(), SettingsTap()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: mintGreen,
      appBar: AppBar(
        backgroundColor: primeColor,
        title: Text(
          "To Do List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: tabs[index],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(Icons.add),
        backgroundColor: primeColor,
        onPressed: () {
          OpenButtonSheet();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: primeColor,
          iconSize: 24,
          selectedFontSize: 0,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
    );
  }

  OpenButtonSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddButtonSheet());
      },
    );
  }
}
