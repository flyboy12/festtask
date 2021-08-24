import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/routes/routes.dart';
import 'package:festtask/widgets/Home/circular_chart.dart';
import 'package:festtask/widgets/Home/navigation_button.dart';
import 'package:festtask/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pr = context.watch<MainProvider>();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            BuildAppBar(),
            CircularChart(
                (pr.eventNotFinishedDay / pr.eventTotalDay),
                (pr.taskNotFinish / pr.taskTotal),
                (pr.routineNotFinish / pr.routineTotal)),
            NavigationCard(
                () => Navigator.pushNamed(context, AppRoutes.event),
                Icon(Icons.today),
                "Yapılacaklar",
                "Yapılacak",
                pr.eventTotalDay,
                pr.eventNotFinishedDay),
            NavigationCard(
                () => Navigator.pushNamed(context, AppRoutes.task),
                Icon(Icons.alarm_on_rounded),
                "Görevler",
                "Görev",
                pr.taskTotal,
                pr.taskNotFinish),
            NavigationCard(
                () => Navigator.pushNamed(context, AppRoutes.routine),
                Icon(
                  Icons.all_inclusive,
                ),
                "Rutinler",
                "Rutin",
                pr.routineTotal,
                pr.routineNotFinish),
          ],
        ),
      ),
    );
  }
}

class BuildHello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height * 0.15,
      width: _size.width - 10,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Merhaba",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
