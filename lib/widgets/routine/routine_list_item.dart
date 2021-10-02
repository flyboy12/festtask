import 'package:festtask/models/routine.dart';
import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/provider/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class RoutineListItem extends StatelessWidget {
  final RoutineModel routine;
  final SlidableController slidableController;

  RoutineListItem(this.routine, this.slidableController);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        controller: slidableController,
        actionExtentRatio: 0.2,
        secondaryActions: [
          IconSlideAction(
            caption: "Sil",
            color: Theme.of(context).errorColor,
            icon: Icons.delete,
            onTap: () {
              context
                  .read<MainProvider>()
                  .deleteRoutine(routine.key, routine.hashCode);
            },
          ),
        ],
        child: Consumer<AppProvider>(
          builder: (_, pr, ch) => Card(
            child: Stack(
              children: [
                Positioned(
                    left: 15, top: 15, child: Text(routine.time ?? "saat")),
                Positioned(
                    left: 85,
                    top: 10,
                    child: Container(
                      width: 3,
                      height: 30,
                      color: Colors.black54,
                    )),
                Positioned(
                    left: 105,
                    top: 15,
                    child: Text(routine.routine ?? "başlık")),
                Positioned(
                    right: 60,
                    top: 2,
                    child: IconButton(
                        icon: Icon(
                          routine.isNotifaction
                              ? Icons.notifications
                              : Icons.notifications_off,
                          size: 30,
                        ),
                        onPressed: () {
                          context
                              .read<AppProvider>()
                              .setNotification(!routine.isNotifaction)
                              .whenComplete(() =>
                                  routine.isNotifaction = pr.notification);
                          context
                              .read<MainProvider>()
                              .updateRoutineNotification(routine)
                              .then(
                                (value) => NotificationApi()
                                    .cancelNotification(routine.hashCode),
                              );
                        })),
                Positioned(
                  right: 10,
                  top: 2,
                  child: Switch(
                    value: routine.isFinish,
                    activeColor: Theme.of(context).accentColor,
                    activeTrackColor: Theme.of(context).primaryColor,
                    onChanged: (bool change) {
                      context
                          .read<AppProvider>()
                          .setRoutineIsFinish(change)
                          .whenComplete(
                              () => routine.isFinish = pr.routineIsFinish);
                      context.read<MainProvider>().updateRoutineFinish(routine);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
