import 'package:hive/hive.dart';
part 'event.g.dart';

@HiveType(typeId: 0)
class EventModel extends HiveObject {
  @HiveField(0)
  String event;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String time;
  @HiveField(4)
  bool isFinish;

  EventModel({
    this.event,
    this.description,
    this.date,
    this.time,
    this.isFinish,
  });
}
