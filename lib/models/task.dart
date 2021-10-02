import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String task;
  @HiveField(1)
  bool isFinish;
  @HiveField(5)
  int status;
  TaskModel({this.task, this.isFinish, this.status = 0});
}
