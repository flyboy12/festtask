import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularChart extends StatelessWidget {
  final double eventPercent;
  final double taskPercent;
  final double routinePercent;
  CircularChart(this.eventPercent, this.taskPercent, this.routinePercent);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height * 0.25,
      width: _size.width - 10,
      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(
              right: 30,
              top: 10,
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 12,
                startAngle: 0.0,
                progressColor: Colors.blue,
                backgroundColor: Theme.of(context).primaryColor,
                percent: eventPercent,
                center: CircularPercentIndicator(
                  radius: 70.0,
                  lineWidth: 8,
                  startAngle: 0.0,
                  progressColor: Colors.blueAccent,
                  backgroundColor: Theme.of(context).primaryColor,
                  percent: taskPercent,
                  center: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 8,
                    startAngle: 0.0,
                    progressColor: Colors.blueGrey,
                    backgroundColor: Theme.of(context).primaryColor,
                    percent: routinePercent,
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          minRadius: 5,
                          maxRadius: 10,
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Yapılacaklar"),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          minRadius: 5,
                          maxRadius: 10,
                          backgroundColor: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Görevler"),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          minRadius: 5,
                          maxRadius: 10,
                          backgroundColor: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Rutinler"),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
