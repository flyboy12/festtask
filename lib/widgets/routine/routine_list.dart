import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/empty_list.dart';
import 'package:festtask/widgets/routine/routine_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class RoutineList extends StatelessWidget {
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final pr = context.watch<MainProvider>().routineList;
    return pr.isEmpty
        ? EmptyList(title: "Şu an Rutininiz Bulunmamaktadır")
        : Consumer<MainProvider>(
            builder: (context, provider, ch) => Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => RoutineListItem(
                    provider.routineList[i], slidableController),
                itemCount: provider.routineList.length,
              ),
            ),
          );
  }
}
