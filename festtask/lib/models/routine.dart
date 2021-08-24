import 'package:hive/hive.dart';
part 'routine.g.dart';

@HiveType(typeId: 2)
class RoutineModel extends HiveObject {
  @HiveField(0)
  String routine;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  bool isFinish;
  @HiveField(3)
  bool isNotifaction;
  @HiveField(4)
  String time;
  @HiveField(5)
  DateTime notificationTime;

  RoutineModel(
      {this.routine,
      this.dateTime,
      this.isFinish,
      this.isNotifaction,
      this.time,
      this.notificationTime});
}
