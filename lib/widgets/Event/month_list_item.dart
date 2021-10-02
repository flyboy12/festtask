import 'package:festtask/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthListItem extends StatelessWidget {
  final int day;

  MonthListItem(
    this.day,
  );
  @override
  Widget build(BuildContext context) {
    final prRead = context.read<MainProvider>();

    return Padding(
      padding: EdgeInsets.all(3),
      child: InkWell(
        onTap: () async {
          prRead.setSelectedDay(day);
          prRead.loadEventWithSelectedDay();
        },
        child: Consumer<MainProvider>(
          builder: (_, provider, ch) => Container(
            height: 20,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: provider.selectedDay == day
                  ? Colors.grey[400]
                  : Colors.grey[300],
            ),
            child: Text(
              day.toString(),
              style: TextStyle(
                  color: provider.selectedDay == day
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
