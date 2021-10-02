import 'package:festtask/provider/main_provider.dart';
import 'package:festtask/widgets/bottom_sheet_navigation.dart';
import 'package:festtask/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController controller;
  AddTaskPage(this.controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        BottomSheetNavigation(() {
          Navigator.of(context).pop();
        }, () {
          if (controller.text == "") {
            print("data not found");
            Navigator.of(context).pop();
          } else {
            context
                .read<MainProvider>()
                .addTask(controller.text)
                .whenComplete(() => Navigator.of(context).pop());
            controller.clear();
          }
        }, 'Yeni Bir Görev'),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CustomTextField(
              controlerText: controller,
              maxLenght: 20,
              labelText: 'Yapacağınız görevi giriniz..'),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
