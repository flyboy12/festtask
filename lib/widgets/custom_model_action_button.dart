import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomModelActionButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave;

  CustomModelActionButton({
    @required this.onClose,
    @required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: onClose,
          buttonText: "Vazgeç",
          textColor: Theme.of(context).accentColor,
        ),
        CustomButton(
          onPressed: onSave,
          buttonText: "Ekle",
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
