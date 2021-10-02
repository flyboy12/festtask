import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/Task/add_task_page.dart';
import 'package:festtask/widgets/Task/task_item.dart';
import 'package:festtask/widgets/build_top_bar.dart';
import 'package:festtask/widgets/fab_add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  _showAddTask(BuildContext context) {
    final TextEditingController taskText = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) => AddTaskPage(taskText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FabItem("add-task", () => _showAddTask(context)),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: context.watch<MainProvider>().selectedTaskBottomIndex,
        onTap: (value) =>
            context.read<MainProvider>().selectTaskBottomIndex(value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: "Hepsi",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Yapılanlar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.clear), label: "Yapılmayacaklar"),
        ],
      ),
      body: Column(
        children: [
          TopBar("Görevlerin"),
          TaskItem(),
        ],
      ),
    );
  }
}
