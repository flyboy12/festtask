import 'package:festtask/models/task.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MainProvider>();
    return provider.taskList.isEmpty
        ? EmptyList(title: "Henüz Bir Göreviniz Yoktur.")
        : Expanded(
            child: _buildTaskList(context),
          );
  }

  Widget _buildTaskList(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, _) => ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: provider.taskList.length,
        itemBuilder: (context, index) {
          final _taskList = provider.taskList;
          switch (_taskList[index].status) {
            case 1:
              return _taskComplete(
                  context,
                  _taskList[index],
                  Icon(
                    Icons.check,
                    size: 20,
                    color: Theme.of(context).accentColor,
                  ));

              break;
            case 2:
              return _taskComplete(
                  context,
                  _taskList[index],
                  Icon(
                    Icons.clear,
                    size: 20,
                    color: Theme.of(context).accentColor,
                  ));
              break;
            default:
              return _taskList[index].isFinish
                  ? _taskComplete(
                      context,
                      _taskList[index],
                      Icon(
                        Icons.radio_button_checked,
                        size: 20,
                        color: Theme.of(context).accentColor,
                      ))
                  : taskUnComplete(
                      context,
                      _taskList[index],
                    );
          }
        },
      ),
    );
  }

  Widget taskUnComplete(BuildContext context, TaskModel itemTask) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 7,
        top: 0,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.radio_button_unchecked),
                  color: Theme.of(context).accentColor,
                  iconSize: 16,
                  onPressed: () {
                    context.read<MainProvider>().doneTask(itemTask);
                  },
                ),
                Text(itemTask.task),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.clear),
                  color: Theme.of(context).accentColor,
                  iconSize: 20,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    context.read<MainProvider>().notDoneTask(itemTask);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.done),
                    iconSize: 20,
                    alignment: Alignment.centerRight,
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      context.read<MainProvider>().doneTask(itemTask);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskComplete(BuildContext context, TaskModel itemTask, Icon icon) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              child: Row(
                children: <Widget>[
                  icon,
                  SizedBox(
                    width: 14,
                  ),
                  Text(itemTask.task),
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: 38),
                    icon: Icon(Icons.update),
                    color: Theme.of(context).accentColor,
                    iconSize: 20,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      context.read<MainProvider>().noneTask(itemTask);
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 38),
                    icon: Icon(Icons.delete_outline),
                    color: Theme.of(context).accentColor,
                    iconSize: 20,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      context.read<MainProvider>().deleteTask(itemTask.key);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
