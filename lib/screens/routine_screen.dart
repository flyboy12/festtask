import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/widgets/build_top_bar.dart';
import 'package:festtask/widgets/fab_add_item.dart';
import 'package:festtask/widgets/routine/add_routine.dart';
import 'package:festtask/widgets/routine/routine_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutineScreen extends StatelessWidget {
  _showAddRoutine(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final pr = context.read<AppProvider>();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) =>
            AddRoutine((a) => pr.setTime(a), pr.time, controller));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton:
          FabItem("add-routine", () => _showAddRoutine(context)),
      body: Column(
        children: [
          TopBar("Rutinin"),
          RoutineList(),
        ],
      ),
    );
  }
}
