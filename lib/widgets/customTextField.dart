import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controlerText;
  final String labelText;
  final int maxLenght;
  CustomTextField(
      {@required this.labelText,
      @required this.controlerText,
      @required this.maxLenght});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: TextField(
        autofocus: false,
        onSubmitted: (a) => FocusScope.of(context).unfocus(),
        controller: controlerText,
        maxLength: maxLenght,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            labelText: labelText),
      ),
    );
  }
}
