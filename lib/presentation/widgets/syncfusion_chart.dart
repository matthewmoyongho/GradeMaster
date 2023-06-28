import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../business_logic/gp_course/gp_course_bloc.dart';
import '../../business_logic/gp_course/gp_course_state.dart';
import '../../business_logic/user/user_cubit.dart';
import '../../business_logic/user/user_state.dart';
import '../../data/models/gp_course.dart';

class SyncfusionChart extends StatefulWidget {
  const SyncfusionChart({Key? key}) : super(key: key);

  @override
  State<SyncfusionChart> createState() => _SyncfusionChartState();
}

class _SyncfusionChartState extends State<SyncfusionChart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<GPCourseBloc, GPCourseState>(
          builder: (context, state) {
            if (state is GPCourseLoaded) {
              List<ChartData> getGPData() {
                List<ChartData> chartData =
                    List.generate(userState.year, (index) {
                  List<GPCourse> yearCourses = [];
                  String yearGP = '0.00';

                  yearCourses.addAll(state.courses
                      .where((course) => course.year == 'Year ${index + 1}'));

                  double totalPoints = 0.0;
                  double totalUnits = 0.0;
                  for (var course in yearCourses) {
                    totalUnits = totalUnits + course.creditUnit;
                    totalPoints = totalPoints + course.points;
                  }
                  yearGP = (totalPoints / totalUnits).toStringAsFixed(2);

                  return ChartData('Yr $index', double.parse(yearGP));
                });
                return chartData;
              }

              return SfCartesianChart(
                series: <ChartSeries>[
                  StackedColumnSeries<ChartData, dynamic>(
                      dataSource: getGPData(),
                      xValueMapper: (ChartData cd, _) => cd.yr,
                      yValueMapper: (ChartData cd, _) => cd.gp)
                ],
                primaryXAxis: CategoryAxis(),
              );
            }
            return SfCartesianChart();
          },
        );
      },
    );
  }
}

class ChartData {
  String yr;
  double gp;

  ChartData(this.yr, this.gp);
}
