import 'package:festtask/models/event.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_icon_decaration.dart';

class EventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    return Consumer<MainProvider>(
      builder: (_, pr, ch) => pr.eventList.isEmpty
          ? EmptyList( title: "Planlanmış Bir Aktiviteniz Yoktur.")
          : Expanded(
              child: ListView.builder(
                itemCount: pr.eventList.length,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  final _eventList = pr.eventList;
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13.0,
                        ),
                        child: _lineStyle(context, iconSize, index,
                            _eventList.length, _eventList[index].isFinish),
                      ),
                      _displayTime(_eventList[index]),
                      _displayContent(context, _eventList[index]),
                    ],
                  );
                },
              ),
            ),
    );
  }

  Expanded _displayContent(BuildContext context, EventModel event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 6.0),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x20000000),
                  blurRadius: 5,
                  offset: Offset(0, 3)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Text(
                      event.event,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(event.description),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.check_circle),
                        color: Theme.of(context).accentColor,
                        iconSize: 20,
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          context.read<MainProvider>().updateEventFinish(event);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        iconSize: 20,
                        alignment: Alignment.centerRight,
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          context.read<MainProvider>().deleteEvent(event.key);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _displayTime(EventModel event) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(event.time),
        ));
  }

  Container _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
      decoration: CustomIconDecarotion(
        iconSize: iconSize,
        lineWidth: 1,
        firstData: index == 0 ?? true,
        lastData: index == listLength - 1 ?? true,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Color(0x20000000),
              blurRadius: 5,
            ),
          ],
        ),
        child: Icon(
          isFinish ? Icons.fiber_manual_record : Icons.radio_button_unchecked,
          size: iconSize,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
