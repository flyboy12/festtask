import 'package:festtask/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopBar extends StatelessWidget {
  final String title;
  TopBar(this.title);
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _date = DateFormat('EE', 'tr').format(date);
    return Container(
      width: size.width,
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            height: 35,
            color: Theme.of(context).accentColor,
          ),
          Positioned(
              left: 0,
              top: 35,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.home);
                  })),
          Positioned(
            right: 0,
            top: 25,
            child: Text(
              "${date.day.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 100,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 130,
            child: Text(
              _date,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 100,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
