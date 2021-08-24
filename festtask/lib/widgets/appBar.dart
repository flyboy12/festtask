import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      color: Theme.of(context).accentColor,
    );
  }
}
