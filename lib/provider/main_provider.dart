import 'dart:async';
import 'package:festtask/models/event.dart';
import 'package:festtask/models/routine.dart';
import 'package:festtask/models/task.dart';
import 'package:festtask/provider/notification.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  static const _boxTaskName = "taskBox";
  static const _boxEventName = "eventBox";
  static const _boxRoutineName = "routineBox";
  List<TaskModel> _taskList = <TaskModel>[];
  List<RoutineModel> _routineList = <RoutineModel>[];
  List<RoutineModel> get routineList => _routineList;
  List<EventModel> _eventList = <EventModel>[];
  List<TaskModel> get taskList => _taskList;
  List<EventModel> get eventList => _eventList;
  Box<TaskModel> taskBox = Hive.box<TaskModel>(_boxTaskName);
  Box<EventModel> eventBox = Hive.box<EventModel>(_boxEventName);
  Box<RoutineModel> routineBox = Hive.box<RoutineModel>(_boxRoutineName);
  int _selectedTaskBottomIndex = 0;
  int get selectedTaskBottomIndex => _selectedTaskBottomIndex;
  int _selectedDay = DateTime.now().day;
  int get selectedDay => _selectedDay;
  double get eventTotalDay => eventBox.values
          .where((element) =>
              element.date.day == DateTime.now().day &&
              element.date.month == DateTime.now().month &&
              element.date.year == DateTime.now().year)
          .isEmpty
      ? 1.0
      : eventBox.values
          .where((element) =>
              element.date.day == DateTime.now().day &&
              element.date.month == DateTime.now().month &&
              element.date.year == DateTime.now().year)
          .length
          .toDouble();
  double get eventFinishedDay => eventBox.values
          .where((element) =>
              element.date.day == DateTime.now().day &&
              element.date.month == DateTime.now().month &&
              element.date.year == DateTime.now().year &&
              element.isFinish == true)
          .isEmpty
      ? eventBox.values
          .where((element) =>
              element.date.day == DateTime.now().day &&
              element.date.month == DateTime.now().month &&
              element.date.year == DateTime.now().year &&
              element.isFinish == true)
          .length
          .toDouble()
      : 1;
  double get eventNotFinishedDay => eventBox.values
          .where((element) =>
              element.date.day == DateTime.now().day &&
              element.date.month == DateTime.now().month &&
              element.date.year == DateTime.now().year &&
              element.isFinish == false)
          .isEmpty
      ? 0
      : eventBox.values
          .where((element) =>
              element.date.day == DateTime.now().day &&
              element.date.month == DateTime.now().month &&
              element.date.year == DateTime.now().year &&
              element.isFinish == false)
          .length
          .toDouble();
  double get taskTotal => taskBox.isEmpty ? 1.0 : taskBox.length.toDouble();
  double get taskNotFinish =>
      taskBox.values.where((e) => e.isFinish == false).isEmpty
          ? 0
          : taskBox.values.where((e) => e.isFinish == false).length.toDouble();
  double get routineTotal =>
      routineBox.values.isEmpty ? 1.0 : routineBox.values.length.toDouble();
  double get routineNotFinish =>
      routineBox.values.where((element) => element.isFinish == false).isEmpty
          ? 0
          : routineBox.values
              .where((element) => element.isFinish == false)
              .length
              .toDouble();
  Future<void> selectTaskBottomIndex(int i) async {
    _selectedTaskBottomIndex = i;
    await loadTask();
    notifyListeners();
  }

  void setSelectedDay(int i) {
    _selectedDay = i;
    notifyListeners();
  }

  Future<void> loadTask() async {
    switch (_selectedTaskBottomIndex) {
      case 0:
        _taskList = taskBox.values.toList();
        notifyListeners();
        break;
      case 1:
        loadTaskStatusDone();
        notifyListeners();
        break;
      case 2:
        loadTaskStatusNotDone();
        notifyListeners();
        break;
      default:
    }

    notifyListeners();
  }

  Future<void> updateRoutineNotification(RoutineModel routine) async {
    !routine.isNotifaction
        ? NotificationApi().cancelNotification(routine.hashCode)
        : setNotification(routine);
    final RoutineModel result = RoutineModel(
        time: routine.time,
        routine: routine.routine,
        dateTime: routine.dateTime,
        isFinish: routine.isFinish,
        isNotifaction: !routine.isNotifaction,
        notificationTime: routine.notificationTime);
    routineBox.put(routine.key, result);
    await loadRoutine();
  }

  Future<void> updateRoutineFinish(RoutineModel routine) async {
    print(!routine.isFinish);
    !routine.isFinish
        ? NotificationApi().cancelNotification(routine.hashCode)
        : setNotification(routine);
    final RoutineModel result = RoutineModel(
        time: routine.time,
        routine: routine.routine,
        dateTime: routine.dateTime,
        isFinish: !routine.isFinish,
        isNotifaction: routine.isNotifaction,
        notificationTime: routine.notificationTime);
    routineBox.put(routine.key, result);
    await loadRoutine();
  }

  Future<void> loadRoutine() async {
    // final yesterDayRoutineList =;
    if (routineBox.isNotEmpty) {
      final controlRoutine = routineBox.values.first.dateTime;
      if (controlRoutine.day == DateTime.now().day) {
        _routineList = routineBox.values.toList()
          ..sort((a, b) => a.time.compareTo(b.time));
      } else {
        routineBox.values.forEach((element) {
          final _routine = RoutineModel(
              routine: element.routine,
              dateTime: DateTime.now(),
              time: element.time,
              isFinish: false,
              isNotifaction: element.isNotifaction);
          routineBox.put(element.key, _routine);
        });
      }
    }

    _routineList = routineBox.values.toList()
      ..sort((a, b) => a.time.compareTo(b.time));

    notifyListeners();
  }

  Future<void> initData() async {
    await loadEventWithSelectedDay();
    await loadTask();
    await loadRoutine();
  }

  Future<void> loadEvent() async {
    _eventList = eventBox.values
        .where((element) =>
            element.date.day == DateTime.now().day &&
            element.date.month == DateTime.now().month &&
            element.date.year == DateTime.now().year)
        .toList()
          ..sort((a, b) => a.time.compareTo(b.time));

    notifyListeners();
  }

  Future<void> loadTaskStatusDone() async {
    _taskList = taskBox.values.where((element) => element.status == 1).toList();
    notifyListeners();
  }

  Future<void> loadTaskStatusNotDone() async {
    _taskList = taskBox.values.where((element) => element.status == 2).toList();
    notifyListeners();
  }

  Future<void> loadEventWithDate(DateTime time) async {
    _eventList = eventBox.values
        .where((element) =>
            element.date.day == time.day &&
            element.date.month == time.month &&
            element.date.year == time.year)
        .toList()
          ..sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  Future<void> loadEventWithSelectedDay() async {
    DateTime now = DateTime.now();
    _eventList = eventBox.values
        .where((element) =>
            element.date.day == _selectedDay &&
            element.date.month == now.month &&
            element.date.year == now.year)
        .toList()
          ..sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  Future<void> addRoutine(String routine, String time, bool isNoti,
      DateTime timeNotification) async {
    final RoutineModel routineModel = RoutineModel(
        routine: routine,
        dateTime: DateTime.now(),
        isFinish: false,
        isNotifaction: isNoti,
        time: time,
        notificationTime: timeNotification);
    await routineBox.add(routineModel);
    if (isNoti) {
      setNotification(routineModel);
    }
    await loadRoutine();
  }

  void setNotification(RoutineModel routine) {
    final _now = DateTime.now();
    final _isAfter = routine.notificationTime.isAfter(_now);
    print(_isAfter);
    if (_isAfter) {
      print("neredesin");
      NotificationApi.showScheduledNotification(
          id: routine.hashCode,
          body: "Yapabilirsin !",
          payload: routine.dateTime.toString(),
          scheduledDate: routine.notificationTime,
          title: routine.routine);
    } else {
      print("saasa");
      final _nextTime = routine.notificationTime.add(Duration(days: 1));

      NotificationApi.showScheduledNotification(
          id: routine.hashCode,
          body: "Yapabilirsin !",
          payload: routine.dateTime.toString(),
          scheduledDate: _nextTime,
          title: routine.routine);

      final RoutineModel result = RoutineModel(
          time: routine.time,
          routine: routine.routine,
          dateTime: routine.dateTime,
          isFinish: routine.isFinish,
          isNotifaction: routine.isNotifaction,
          notificationTime: _nextTime);
      routineBox.put(routine.key, result);
    }

    notifyListeners();
  }

  Future<void> deleteRoutine(int id, int hashCode) async {
    _routineList.removeWhere((element) => element.key == id);
    await routineBox.delete(id);
    NotificationApi().cancelNotification(hashCode);
    await loadRoutine();
  }

  Future<void> addTask(String task) async {
    final TaskModel taskModel =
        TaskModel(task: task, isFinish: false, status: 0);

    await taskBox.add(taskModel);
    await loadTask();
  }

  Future<void> deleteTask(int id) async {
    _taskList.removeWhere((element) => element.key == id);
    await taskBox.delete(id);
    await loadTask();
  }

  Future<void> notDoneTask(TaskModel model) async {
    final _task = TaskModel(task: model.task, isFinish: false, status: 2);
    taskBox.put(model.key, _task);
    await loadTask();
  }

  Future<void> noneTask(TaskModel model) async {
    final _task = TaskModel(task: model.task, isFinish: false, status: 0);
    taskBox.put(model.key, _task);
    await loadTask();
  }

  Future<void> doneTask(TaskModel task) async {
    final TaskModel result =
        TaskModel(task: task.task, isFinish: !task.isFinish, status: 1);
    taskBox.put(task.key, result);
    await loadTask();
  }

  Future<void> addEvent(EventModel event) async {
    await eventBox.add(event);
    setSelectedDay(DateTime.now().day);
    loadEventWithSelectedDay();
  }

  Future<void> deleteEvent(int id) async {
    _eventList.removeWhere((element) => element.key == id);
    await eventBox.delete(id);
    setSelectedDay(DateTime.now().day);
    loadEventWithSelectedDay();
  }

  Future<void> updateEventFinish(EventModel event) async {
    final EventModel result = EventModel(
        event: event.event,
        date: event.date,
        time: event.time,
        description: event.description,
        isFinish: !event.isFinish);
    eventBox.put(event.key, result);
    await loadEventWithDate(event.date);
  }
}
