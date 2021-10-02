import 'package:flutter/material.dart';

class BottomSheetNavigation extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave;
  final String text;

  BottomSheetNavigation(this.onClose, this.onSave, this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).errorColor,
          ),
          onPressed: onClose,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        IconButton(
          icon: Icon(
            Icons.done,
          ),
          onPressed: onSave,
        ),
      ],
    );
  }
}
