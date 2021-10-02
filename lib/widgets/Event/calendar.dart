import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/routes/routes.dart';
import 'package:festtask/widgets/appBar.dart';
import 'package:festtask/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prApp = context.watch<AppProvider>();
    return WillPopScope(
      onWillPop: () {
        prApp.setDateTime(DateTime.now());
        context.read<MainProvider>().loadEvent();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            BuildAppBar(),
            Theme(
              data: ThemeData(primarySwatch: Colors.blueGrey),
              child: CalendarDatePicker(
                  initialDate: prApp.dateTime,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                  onDateChanged: (date) {
                    prApp.setDateTime(date);
                    context.read<MainProvider>().loadEventWithDate(date);
                  }),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        onPressed: () {
                          context
                              .read<MainProvider>()
                              .loadEventWithSelectedDay()
                              .then((value) => context
                                  .read<MainProvider>()
                                  .setSelectedDay(DateTime.now().day));
                          Navigator.pushNamed(context, AppRoutes.home);
                        }),
                  ),
                  Positioned(
                    top: 11,
                    left: 40,
                    child: Text(
                      "Seçilen Tarih:",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 22),
                    ),
                  ),
                  Positioned(
                    top: 11,
                    right: 0,
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(prApp.dateTime),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<MainProvider>(
              builder: (context, dataList, _) => dataList.eventList.isEmpty
                  ? EmptyList(
                      title: "Bugün için planladığınız bir olay yok.",
                      height: 0.2,
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          final event = dataList.eventList[i];
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            color: Theme.of(context).primaryColor,
                            height: 60,
                            width: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                    left: 10,
                                    top: 15,
                                    child: Text(
                                      event.time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColorLight),
                                    )),
                                Positioned(
                                    left: 80,
                                    top: 4,
                                    child: Text.rich(TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                        text: "${event.event}\n",
                                        children: [
                                          TextSpan(text: event.description)
                                        ]))),
                              ],
                            ),
                          );
                        },
                        itemCount: dataList.eventList.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
