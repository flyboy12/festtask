import 'package:flutter/material.dart';

class NavigationCard extends StatelessWidget {
  final Function func;
  final Icon icon;
  final String title;
  final String subTitle;
  final double number;
  final double notFinished;

  NavigationCard(this.func, this.icon, this.title, this.subTitle, this.number,
      this.notFinished);
  @override
  Widget build(BuildContext context) {
    final double _toValue = (notFinished / number).toDouble();
    final _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: func,
      child: Container(
        height: _size.height * 0.20,
        width: _size.width * 0.99,
        padding: EdgeInsets.all(8),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Positioned(
                  top: 15,
                  left: 15,
                  child: Text(
                    "${notFinished.toInt().toString()} $subTitle",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black.withOpacity(0.4)),
                  )),
              Positioned(
                  top: 35,
                  left: 13,
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 25))),
              Positioned(
                bottom: 20,
                left: 15,
                child: SizedBox(
                  width: _size.width * 0.8,
                  child: LinearProgressIndicator(
                    value: _toValue ?? 0.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
