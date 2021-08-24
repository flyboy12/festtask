import 'package:festtask/models/month.dart';
import 'package:festtask/routes/routes.dart';
import 'package:festtask/widgets/Event/month_list_item.dart';
import 'package:flutter/material.dart';

class MonthList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _day = DateTime.now().day;
    ScrollController _controller = ScrollController(
      initialScrollOffset: (_day.toDouble() - 1) * 39.0,
      keepScrollOffset: true,
    );

    final List monthDay = month[DateTime.now().month - 1];
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
              child: ListView.builder(
            controller: _controller,
            itemBuilder: (_, i) => MonthListItem(monthDay[i]),
            scrollDirection: Axis.horizontal,
            itemCount: monthDay.length,
          )),
          IconButton(
              icon: Icon(Icons.calendar_today_rounded),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.calendar)),
        ],
      ),
    );
  }
}
