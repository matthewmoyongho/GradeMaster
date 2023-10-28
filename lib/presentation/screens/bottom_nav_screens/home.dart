import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../../../business_logic/assignment/timetable/timetable_state.dart';
import '../../../../business_logic/authentication/authentication_bloc.dart';
import '../../../../business_logic/authentication/authentication_event.dart';
import '../../../../business_logic/authentication/authentication_state.dart';
import '../../../../business_logic/user/user_cubit.dart';
import '../../../../business_logic/user/user_state.dart';
import '../../../../constants.dart';
import '../../../../data/models/time_table_course.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/course_lecture_tile.dart';
import '../../widgets/gp_tile.dart';
import '../../widgets/section_tile.dart';

class Home extends StatelessWidget {
  String? username = 'User';
  String today = DateFormat('EEEE').format(DateTime.now());
  String month = DateFormat('MMM').format(DateTime.now());
  String date = DateFormat('d').format(DateTime.now());
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final deviceSize = MediaQuery.of(context).size;
    final fbuser = FirebaseAuth.instance.currentUser;

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
          title: const Text('Home'),
          elevation: 0,
          backgroundColor: Colors.blue[900],
          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return TextButton.icon(
                    label: const Text('Sign Out'),
                    onPressed: () =>
                        context.read<AuthenticationBloc>().add(LogOutRequest()),
                    icon: const Icon(Icons.logout));
              },
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[900],
                // borderRadius: BorderRadius.circular(30),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.blue[500],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.35,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: deviceSize.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: deviceSize.width * .6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      'Hi ${state.name ?? 'User'}',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateTime.now().hour < 12
                                        ? 'Good morning!'
                                        : DateTime.now().hour < 16 &&
                                                DateTime.now().hour >= 12
                                            ? 'Good afternoon'
                                            : DateTime.now().hour < 20 &&
                                                    DateTime.now().hour >= 16
                                                ? 'Good evening'
                                                : DateTime.now().hour < 24 &&
                                                        DateTime.now().hour >=
                                                            20
                                                    ? 'Good evening'
                                                    : 'Good day!',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.blueGrey,
                              backgroundImage: user.photoUrl != null
                                  ? NetworkImage(user.photoUrl!)
                                  : null,
                              child: user.photoUrl == null
                                  ? const Icon(
                                      Icons.person_outline,
                                      size: 35,
                                    )
                                  : null,
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: deviceSize.height * .02,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: deviceSize.height * .14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(kClassesScreen),
                                child: FittedBox(
                                  child: SectionTile(
                                    'Classes',
                                    Icons.book,
                                  ),
                                )),
                            GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(kTimeTableScreen),
                                child: FittedBox(
                                  child: SectionTile(
                                    'TimeTable',
                                    Icons.schedule_outlined,
                                  ),
                                )),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(kAssignmentScreen),
                              child: FittedBox(
                                child: SectionTile(
                                  'Assignment',
                                  Icons.assignment,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.white,
                      child: Container(
                        height: deviceSize.height * .24,
                        decoration: const BoxDecoration(),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.schedule, color: Colors.deepOrange),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Today\'s Schedule',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: deviceSize.height * .01,
                            ),
                            BlocBuilder<TimetableBloc, TimetableState>(
                              builder: (context, state) {
                                if (state is TimetableLoaded) {
                                  final courses = [];
                                  courses.addAll(
                                    state.courses.where((course) =>
                                        course.day.toUpperCase() ==
                                        DateFormat('EEEE')
                                            .format(DateTime.now())
                                            .toUpperCase()),
                                  );

                                  if (courses.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No activity for today',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: deviceSize.height * .15,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: courses.length,
                                          itemBuilder: (context, index) {
                                            TimeTableCourse course =
                                                courses[index];

                                            TimeOfDay stopTime = TimeOfDay(
                                                hour: int.parse((courses[index]
                                                        .stopTime
                                                        .toString())
                                                    .substring(0, 2)),
                                                minute: int.parse((courses[index]
                                                        .stopTime
                                                        .toString())
                                                    .substring(
                                                        2,
                                                        (courses[index].stopTime)
                                                                    .toString()
                                                                    .length >
                                                                3
                                                            ? 4
                                                            : 3)));
                                            TimeOfDay startTime = TimeOfDay(
                                              hour: courses[index]
                                                          .startTime
                                                          .toString()
                                                          .length <
                                                      3
                                                  ? int.parse((courses[index]
                                                          .startTime
                                                          .toString())
                                                      .substring(0, 1))
                                                  : int.parse((courses[index]
                                                          .startTime
                                                          .toString())
                                                      .substring(0, 2)),
                                              minute: courses[index]
                                                          .startTime
                                                          .toString()
                                                          .length <
                                                      3
                                                  ? 0
                                                  : int.parse(
                                                      (courses[index]
                                                              .startTime
                                                              .toString())
                                                          .substring(
                                                        2,
                                                        (courses[index].startTime)
                                                                    .toString()
                                                                    .length >
                                                                3
                                                            ? 4
                                                            : 3,
                                                      ),
                                                    ),
                                            );

                                            return CourseLectureTile(
                                              time:
                                                  '${startTime.format(context)} - ${stopTime.format(context)}',
                                              month: month,
                                              courseTitle: course.title!,
                                              date: date,
                                              lecturer: '',
                                            );
                                          }),
                                    );
                                  }
                                } else if (state is TimetableLoading) {
                                  return const Center(
                                    child: Text(
                                      'loading...',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18,
                                          color: Colors.blueGrey),
                                    ),
                                  );
                                }

                                return const Center(
                                  child: Text(
                                    'Could not load your today\'s activity',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GPTile(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();

    path.lineTo(0, size.height);
    var controlPoint = Offset((size.width / 2), size.height - 40);
    //var controlPoint = Offset((size.width / 2) * 1.7, size.height - 100);
    var endpoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endpoint.dx, endpoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    //TODO: implement shouldReclip
    return true;
  }
}
