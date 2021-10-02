import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String value;
  final double width;

  CustomDatePicker({
    @required this.onPressed,
    @required this.icon,
    @required this.value,
    this.width = 0,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: width == 0 ? MediaQuery.of(context).size.width - 80 : width,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Icon(icon, color: Theme.of(context).accentColor, size: 30),
              SizedBox(
                width: 12,
              ),
              Text(value, style: TextStyle(fontSize: 14, color: Colors.black)),
            ],
          ),
        ));
  }
}
