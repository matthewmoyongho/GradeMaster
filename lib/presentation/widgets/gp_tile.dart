import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/gp_course/gp_course_bloc.dart';
import '../../business_logic/gp_course/gp_course_state.dart';

class GPTile extends StatelessWidget {
  GPTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //() => Navigator.of(context).pushNamed(kGreatPointOverViewScreen),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                      child: Icon(
                        Icons.gps_fixed_sharp,
                        color: Colors.green,
                      ),
                      alignment: PlaceholderAlignment.middle),
                  TextSpan(
                    text: ' CGPA',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            ),
            BlocBuilder<GPCourseBloc, GPCourseState>(
              builder: (context, state) {
                if (state is GPCourseLoading) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Fetching GP data...',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  );
                } else if (state is GPCourseLoaded) {
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          double.parse(state.cgpa).isNaN ? '0.00' : state.cgpa,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const FittedBox(
                        child: Text(
                          'Click here to view your academic record',
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  );
                }
                return const Text(
                  'GP data is empty',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
