import 'package:flutter/material.dart';

import '../../data/models/grades.dart';

class GradeSummaryGridView extends StatelessWidget {
  Grades grades;
  GradeSummaryGridView({super.key, required this.grades});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 1,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3),
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: Text(
              '${grades.a} A\'s',
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: Text(
              '${grades.b} B\'s',
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: Text(
              '${grades.c} C\'s',
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: Text(
              '${grades.d} D\'s',
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: Colors.blue[300],
            child: Text(
              '${grades.e} E\'s',
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: Text(
              '${grades.f} \'s',
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
