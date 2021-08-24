import 'package:festtask/models/description.dart';
import 'package:festtask/models/event.dart';
import 'package:festtask/provider/app_provider.dart';
import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/bottom_sheet_navigation.dart';
import 'package:festtask/widgets/customTextField.dart';
import 'package:festtask/widgets/custom_date.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddEventPage extends StatelessWidget {
  final List<Description> items;
  final TextEditingController eventText;
  final Description selectedItem;
  final Function setDateTime;
  final Function setTime;
  final Function setSelectedItem;
  final DateTime dateTime;
  final TimeOfDay timeOf;

  const AddEventPage(
      this.items,
      this.eventText,
      this.selectedItem,
      this.dateTime,
      this.timeOf,
      this.setTime,
      this.setDateTime,
      this.setSelectedItem);
  @override
  Widget build(BuildContext context) {
    final pr = context.watch<AppProvider>();
    Future _pickDate() async {
      final DateTime pick = await showDatePicker(
          locale: Locale('tr'),
          context: context,
          initialDate: dateTime,
          firstDate: DateTime.now().add(Duration(days: -365)),
          builder: (BuildContext context, Widget child) {
            return Theme(
                data: ThemeData(primarySwatch: Colors.blueGrey), child: child);
          },
          lastDate: DateTime.now().add(Duration(days: 365)));
      if (pick != null && pick != dateTime) {
        setDateTime(pick);
      }
      // setState(() {
      //   _selectedDate = datepick;
      // });
    }

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

    // final MaterialLocalizations localizations = MaterialLocalizations.of(context); //yerel bölge saatinin dönüştürmesini yapıyor.

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetNavigation(() {
            Description _d;
            setTime(TimeOfDay.now());
            setDateTime(DateTime.now());
            setSelectedItem(_d);
            Navigator.pop(context, false);
          }, () {
            Description _d;
            final event = EventModel(
                event: eventText.text,
                isFinish: false,
                date: dateTime,
                time: timeOf.format(context),
                description: selectedItem.desc);

            context
                .read<MainProvider>()
                .addEvent(event)
                .whenComplete(() => Navigator.of(context).pop());
            setTime(TimeOfDay.now());
            setDateTime(DateTime.now());
            setSelectedItem(_d);
          }, "Yeni Yapılacağı Ekleme"),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
              labelText: "Ne Yapmayı Planlıyorsunuz",
              controlerText: eventText,
              maxLenght: 13),
          SizedBox(
            height: 12,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 80,
            child: DropdownButton<Description>(
                isExpanded: true,
                isDense: true,
                value: pr.selectedItem,
                hint: Text(
                  "Etiket Seçiniz",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
                items: items.map((Description desc) {
                  return DropdownMenuItem<Description>(
                    value: desc,
                    child: Row(
                      children: <Widget>[
                        Text(
                          desc.desc,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        )
                      ],
                    ),
                  );
                }).toList(),
                onChanged: setSelectedItem),
          ),
          SizedBox(
            height: 12,
          ),
          Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.blueGrey),
            child: CustomDatePicker(
                onPressed: _pickDate,
                icon: Icons.date_range,
                value: DateFormat("dd-MM-yyyy").format(pr.dateTime)),
          ),
          CustomDatePicker(
            onPressed: _pickTime,
            icon: Icons.access_time,
            value: pr.time.format(context),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
