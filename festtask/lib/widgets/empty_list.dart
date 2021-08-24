import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String title;
  final double height;
  EmptyList({@required this.title, this.height = 0.6});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            size: 35,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
