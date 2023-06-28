import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../business_logic/assignment/timetable/timetable_state.dart';
import '../../constants.dart';
import '../../data/models/time_table_course.dart';
import '../widgets/classes_tile.dart';

class ClassesScreen extends StatelessWidget {
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
        child: Container(
          color: Colors.blue[900],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(kTimeTableScreen),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  label: const Text(
                    'View Your Timetable',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  '$kToday $kMonth. $kDate',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'MY CLASSES',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                height: deviceSize.height * 0.65,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: BlocBuilder<TimetableBloc, TimetableState>(
                  builder: (context, state) {
                    List<TimeTableCourse> courses = [];
                    if (state is TimetableLoading) {
                      return Container(
                        height: 100,
                        width: double.infinity,
                        child: const Center(
                          child: Text('Loading your courses'),
                        ),
                      );
                    }
                    if (state is TimetableLoaded) {
                      courses.addAll(
                        state.courses.where((course) =>
                            course.day ==
                            DateFormat('EEEE').format(DateTime.now())),
                      );

                      return courses.isNotEmpty
                          ? Container(
                              width: double.infinity,
                              height: deviceSize.height * 0.2,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: courses.length,
                                itemBuilder: (context, index) {
                                  return ClassesTile(
                                      document: courses, index: index);
                                },
                              ),
                            )
                          : Container(
                              height: 100,
                              width: double.infinity,
                              child: const Center(
                                child: Text('No class for today🤗😇'),
                              ),
                            );
                      ;
                    }
                    return Container(
                      height: 100,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                            'Oops!!! Could not load your classes for today!',
                            softWrap: true),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
