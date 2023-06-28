import 'package:flutter/material.dart';

class GPProgressBar extends StatelessWidget {
  final double gp;
  GPProgressBar(this.gp);

  Color setColor(double? gp) {
    final progressColor;
    if (gp == null) {
      progressColor = Colors.transparent;
    } else if (gp >= 4.5) {
      progressColor = Colors.blue[900];
    } else if (gp >= 3.5) {
      progressColor = Colors.green;
    } else if (gp >= 2.5) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.red;
    }
    return progressColor;
  }

  @override
  Widget build(BuildContext context) {
    return gp.isNaN
        ? SizedBox()
        : Container(
            decoration: BoxDecoration(
              color: setColor(gp),
              borderRadius: BorderRadius.circular(10),
            ),
            width: (gp / 5) * MediaQuery.of(context).size.width,
            height: 6,
          );
  }
}
