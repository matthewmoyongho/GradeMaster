import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../business_logic/assignment/timetable/timetable_state.dart';
import '../../constants.dart';
import '../widgets/custom_bottomsheet.dart';
import '../widgets/daily_table.dart';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue[900],
        statusBarColor: Colors.blue[900],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            color: Colors.blue[900],
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(kClassesScreen),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    label: const Text(
                      'View Only Classes For Today',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    icon: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$kToday $kMonth. $kDate',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.bottomLeft,
                    child: const FittedBox(
                      child: Text(
                        'MY LECTURE TIMETABLE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  height: deviceSize.height * 0.75,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(deviceSize.width * 0.8, 50),
                              backgroundColor: Colors.blue[900]),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                //barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return CustomBottomSheet();
                                });
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(fontSize: 30),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(),
                      Container(
                        height: deviceSize.height * 0.6,
                        child: BlocBuilder<TimetableBloc, TimetableState>(
                          builder: (context, state) {
                            if (state is TimetableLoaded) {
                              if (state.courses.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'You\'ve not added to your timetable yet',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                );
                              } else {
                                return ListView(
                                  children: [
                                    Column(
                                      children: [
                                        DailyTable(
                                          day: 'Monday',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DailyTable(
                                          day: 'Tuesday',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DailyTable(
                                          day: 'Wednesday',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DailyTable(
                                          day: 'Thursday',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DailyTable(
                                          day: 'Friday',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DailyTable(
                                          day: 'Saturday',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DailyTable(
                                          day: 'Sunday',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              }
                            } else if (state is TimetableLoading) {
                              return const Center(
                                child: Text(
                                  'Loading courses',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                      fontSize: 12),
                                ),
                              );
                            }

                            return const Center(
                              child: Text(
                                'Please give me some time to load your timetable',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
