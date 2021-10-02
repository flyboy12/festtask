import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FabItem extends StatelessWidget {
  final Function onPressed;
  final String hero;
  FabItem(this.hero, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: hero,
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
