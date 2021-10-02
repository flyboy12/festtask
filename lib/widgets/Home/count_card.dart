import 'package:festtask/provider/main_provider.dart';
import 'package:flutter/material.dart';

Widget buildCountCard(MainProvider prWatch, BuildContext context) {
  return Container(
    height: 80,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Theme.of(context).accentColor,
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text.rich(
          TextSpan(
            text: "Görevler\n",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 22, color: Colors.white.withOpacity(0.6)),
          ),
          textAlign: TextAlign.start,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, right: 5),
          child: Text.rich(
            TextSpan(
                text: "\n${prWatch.taskList.length}",
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: 22, color: Colors.white.withOpacity(0.8))),
            textAlign: TextAlign.right,
          ),
        ),
        VerticalDivider(
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
        Text.rich(
          TextSpan(
            text: "Bugün\nYapacakların\n",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 22, color: Colors.white.withOpacity(0.6)),
          ),
          textAlign: TextAlign.start,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, right: 5),
          child: Text.rich(
            TextSpan(
                text: "\n${prWatch.eventList.length}",
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: 22, color: Colors.white.withOpacity(0.8))),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}
