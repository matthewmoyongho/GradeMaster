import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/gp_course/gp_course_bloc.dart';
import '../../../../business_logic/gp_course/gp_course_state.dart';
import '../../../../business_logic/user/user_cubit.dart';
import '../../../../business_logic/user/user_state.dart';
import '../../../../constants.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/year_summary_tile.dart';

class GreatPointOverViewScreen extends StatelessWidget {
  const GreatPointOverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final userData = context.select((UserCubit cubit) => cubit.state);
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Exit app?'),
                      content: const Text('Press \'OK\' to confirm'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('OK')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancel')),
                      ],
                    )) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GP Overview'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: BlocBuilder<GPCourseBloc, GPCourseState>(
            builder: (context, state) {
              if (state is GPCourseLoading) {
                return const Center(
                  child: Text(
                    'Loading',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                );
              }
              if (state is GPCourseLoaded) {
                if (state.courses.isEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(15),
                    child: const Center(
                      child: Text(
                        'You have not added any record yet. click on the floating button bellow to add',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  width: double.infinity,
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue[900],
                              ),
                              child: const Center(
                                child: Text(
                                  'CURRENT CGPA',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(100),
                            elevation: 5,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .45,
                              padding: const EdgeInsets.all(15),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[900],
                              ),
                              child: Center(
                                child: Text(
                                  double.parse(state.cgpa).isNaN
                                      ? '0.00'
                                      : state.cgpa,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 50),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          // Material(
                          //   borderRadius: BorderRadius.circular(15),
                          //   elevation: 5,
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         width: double.infinity,
                          //         padding: EdgeInsets.all(15),
                          //         height: 50,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(15),
                          //           //color: Colors.blue[900],
                          //         ),
                          //         child: Center(
                          //           child: Text(
                          //             'CGPA progress chart ',
                          //             style: TextStyle(
                          //                 color: Colors.blue[900],
                          //                 fontSize: 18),
                          //           ),
                          //         ),
                          //       ),
                          //       Container(
                          //         width: double.infinity,
                          //         padding: EdgeInsets.all(15),
                          //         height: 320,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(15),
                          //           // color: Colors.blue[900],
                          //         ),
                          //         child:
                          //             BlocBuilder<GPCourseBloc, GPCourseState>(
                          //           builder: (context, state) {
                          //             if (state is GPCourseLoaded) {
                          //               List<FlSpot> spots = [];
                          //               List.generate(userState.year, (index) {
                          //                 for (int i = 0; i <= index; i++) {
                          //                   final yearCourses = List.from(
                          //                     state.courses.where((course) =>
                          //                         course.year ==
                          //                         'Year ${index + 1}'),
                          //                   );
                          //                   String yearGP;
                          //                   double totalPoints = 0.0;
                          //                   double totalUnits = 0.0;
                          //                   yearCourses.forEach((course) {
                          //                     totalUnits = totalUnits +
                          //                         course.creditUnit;
                          //                     totalPoints =
                          //                         totalPoints + course.points;
                          //                   });
                          //
                          //                   yearGP = (totalPoints / totalUnits)
                          //                       .toStringAsFixed(2);
                          //
                          //                   spots.add(FlSpot(index + 1,
                          //                       double.parse(yearGP)));
                          //                 }
                          //               });
                          //               return Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   GPChart(
                          //                     year: userState.year,
                          //                     flSpots: [],
                          //                   ),
                          //                 ],
                          //               );
                          //             }
                          //             return Text('Loading...');
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // color: Colors.blue[900],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            width: double.infinity,
                            //alignment: Alignment.center,
                            child: Text(
                              'Years',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 18),
                            ),
                          ),
                          Column(
                            children: List.generate(userState.year, (index) {
                              return YearSummaryTile(
                                year: 'Year ${index + 1}',
                              );
                            }),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text(
                  'Unable to load your data at the moment. Try refreshing your network',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue[900],
          onPressed: () => {
            Navigator.of(context).pushNamed(kYearScreenRoute),
          },
          label: const Text('Add to your GP record'),
        ),
      ),
    );
  }
}
// SyncfusionChart()
// GPChart(
//   // years: 4,
//   numberOfYears: userState.year,
//   overallGPA:
//       double.parse(state.cgpa),
//   flSpots: List.generate(
//       userState.year, (index) {
//     for (int i = 0;
//         i <= index;
//         i++) {
//       final yearCourses = List.from(
//         state.courses.where(
//             (course) =>
//                 course.year ==
//                 'Year $index'),
//       );
//
//       String yearGP;
//       double totalPoints = 0.0;
//       double totalUnits = 0.0;
//       yearCourses.forEach((course) {
//         totalUnits = totalUnits +
//             course.creditUnit;
//         totalPoints = totalPoints +
//             course.points;
//       });
//       yearGP =
//           (totalPoints / totalUnits)
//               .toStringAsFixed(2);
//
//       gpa.add(yearGP);
//     }
//     return FlSpot(index.toDouble(),
//         double.parse(gpa[index]));
//   }),
// ),
