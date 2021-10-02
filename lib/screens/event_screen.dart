import 'package:festtask/models/description.dart';
import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/widgets/Event/add_event_page.dart';
import 'package:festtask/widgets/Event/event_item.dart';
import 'package:festtask/widgets/Event/month_List.dart';
import 'package:festtask/widgets/build_top_bar.dart';
import 'package:festtask/widgets/fab_add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatelessWidget {
  _showAddEvent(BuildContext context) {
    final prRead = Provider.of<AppProvider>(context, listen: false);

    final TextEditingController eventText = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => ListenableProvider.value(
              value: prRead,
              child: AddEventPage(
                  prRead.items,
                  eventText,
                  prRead.selectedItem,
                  prRead.dateTime,
                  prRead.time,
                  (a) => prRead.setTime(a),
                  (d) => prRead.setDateTime(d),
                  (Description s) => prRead.setSelectedItem(s)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FabItem("add-event", () => _showAddEvent(context)),
      body: Column(
        children: [
          TopBar("Aktivitelerin"),
          MonthList(),
          EventItem(),
        ],
      ),
    );
  }
}
