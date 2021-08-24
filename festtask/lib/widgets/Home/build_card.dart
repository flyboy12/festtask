import 'package:festtask/routes/routes.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          _categoryCard(context, "Aktivitelerin",
              () => Navigator.pushNamed(context, AppRoutes.event)),
          _categoryCard(context, "Görevlerin",
              () => Navigator.pushNamed(context, AppRoutes.task)),
          _categoryCard(context, "Rutinin",
              () => Navigator.pushNamed(context, AppRoutes.routine)),
        ],
      ),
    );
  }
}

Widget _categoryCard(
  BuildContext context,
  String title,
  Function onTap,
) {
  final size = MediaQuery.of(context).size;
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 8.0,
      margin: EdgeInsets.all(10),
      child: Container(
        width: (size.width / 2.0) - 20.0,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(child: Text(title)),
      ),
    ),
  );
}
