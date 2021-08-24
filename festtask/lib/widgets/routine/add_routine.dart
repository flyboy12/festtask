import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/bottom_sheet_navigation.dart';
import 'package:festtask/widgets/customTextField.dart';
import 'package:festtask/widgets/custom_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoutine extends StatelessWidget {
  final TimeOfDay timeOf;
  final Function setTime;
  final TextEditingController routineText;
  AddRoutine(this.setTime, this.timeOf, this.routineText);

  @override
  Widget build(BuildContext context) {
    final pr = context.watch<AppProvider>();
    Future _pickTime() async {
      final TimeOfDay time = await showTimePicker(
          context: context,
          initialTime: timeOf,
          builder: (BuildContext context, Widget child) => Theme(
              data: ThemeData(primarySwatch: Colors.blueGrey), child: child));
      if (time == null) {
        setTime(TimeOfDay.now());
      } else {
        setTime(time);
      }
      // setState(() {
      //   _time = t;
      // });
    }

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomSheetNavigation(
            () {
              Navigator.of(context).pop();
            },
            () {
              if (routineText.text.isEmpty) {
              } else {
                final _now = DateTime.now();

                final _notificationTime = DateTime(_now.year, _now.month,
                    _now.day, timeOf.hour, timeOf.minute);

                context.read<MainProvider>().addRoutine(routineText.text,
                    timeOf.format(context), pr.notification, _notificationTime);
              }

              routineText.clear();
              setTime(TimeOfDay.now());

              Navigator.pop(context);
            },
            "Yeni Bir Rutin",
          ),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
              labelText: 'Rutinizi giriniz..',
              controlerText: routineText,
              maxLenght: 20),
          SizedBox(
            height: 12,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(
                flex: 1,
              ),
              CustomDatePicker(
                onPressed: _pickTime,
                icon: Icons.access_time,
                value: pr.time.format(context),
                width: 150,
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                    icon: Icon(pr.notification
                        ? Icons.notifications
                        : Icons.notifications_none),
                    onPressed: () {
                      print(pr.notification);
                      pr.setNotification(!pr.notification);
                      pr.setTime(TimeOfDay.now());
                    }),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
