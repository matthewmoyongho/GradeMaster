import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/gp_course/gp_course_bloc.dart';
import '../../../business_logic/gp_course/gp_course_event.dart';
import '../../../business_logic/gp_course/gp_course_state.dart';
import '../../../business_logic/user/user_cubit.dart';
import '../../../business_logic/user/user_state.dart';
import '../../../constants.dart';
import '../../../data/models/gp_course.dart';
import '../../widgets/add_year_bottomsheet.dart';

class YearScreen extends StatefulWidget {
  @override
  State<YearScreen> createState() => _YearScreenState();
}

class _YearScreenState extends State<YearScreen> {
  showAlertDialog(BuildContext context, String year) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              backgroundColor: Colors.blue[900],
              title: const Text(
                'Action alert!',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 70,
                  ),
                  Text(
                    'Choose an action to be performed on the selected course',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<GPCourseBloc>().add(ClearGPRecord());
                          Navigator.of(context).pop();
                        },
                        child: const FittedBox(
                          child: Text(
                            'Clear Records',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.white70,
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(kSemesterScreenRoute, arguments: year),
                          child: const FittedBox(
                            child: Text(
                              'View records',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )),
                      const VerticalDivider(
                        color: Colors.white70,
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const FittedBox(
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ));
  }

  void displaySnackbar(String content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: const Text('Years'),
        actions: [
          PopupMenuButton(
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 'Clear CGPA Records',
                      child: Text('Clear CGPA Records'),
                    ),
                  ],
              onSelected: (val) {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          title: const Text(
                            'Clear all CGPA Record!',
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 70,
                              ),
                              Text(
                                'By confirming this, all your records for GPA will be deleted',
                              ),
                            ],
                          ),
                          actions: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<GPCourseBloc>()
                                            .add(ClearGPRecord());
                                        BlocProvider.of<UserCubit>(context)
                                            .resetYear(
                                                id: FirebaseAuth
                                                    .instance.currentUser!.uid);
                                        Navigator.of(context).pop();
                                      },
                                      child: const FittedBox(
                                        child: Text(
                                          'Clear Records',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )),
                                  const VerticalDivider(
                                    color: Colors.white70,
                                  ),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const FittedBox(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ));
              }),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
        if (userState.userDataStatus == UserDataStatus.userDataLoading) {
          if (userState.year == 0) {
            return Container(
              padding: const EdgeInsets.all(15),
              height: deviceSize.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.hourglass_empty,
                    size: 50,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Oops... Nothing here!',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text('Click the add icon bellow to add a year',
                      style: TextStyle(fontSize: 17)),
                ],
              ),
            );
          }
          // if (userState.userDataStatus == UserDataStatus.userDataLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return Container(
            padding: const EdgeInsets.all(15),
            height: deviceSize.height,
            width: double.infinity,
            child: BlocBuilder<GPCourseBloc, GPCourseState>(
              builder: (context, state) {
                return ListView(
                  children: List.generate(userState.year, (index) {
                    List<GPCourse> yearCourses = [];
                    yearCourses.addAll(
                      state.courses.where(
                          (course) => course.year == 'Year ${index + 1}'),
                    );
                    String yearGP;
                    double totalPoints = 0.0;
                    double totalUnits = 0.0;
                    for (var course in yearCourses) {
                      totalUnits = totalUnits + course.creditUnit;
                      totalPoints = totalPoints + course.points;
                    }
                    yearGP = (totalPoints / totalUnits).toStringAsFixed(2);
                    return GestureDetector(
                      onDoubleTap: () => showAlertDialog(
                        context,
                        'Year ${index + 1}',
                      ),
                      onTap: () => Navigator.of(context).pushNamed(
                          kSemesterScreenRoute,
                          arguments: 'Year ${index + 1}'),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side:
                                BorderSide(color: Colors.blue[900]!, width: 2)),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 100,
                                color: Colors.blue[900],
                                width: deviceSize.width * .3,
                                child: Center(
                                    child: Text(
                                  'Year ${index + 1}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 100,
                                  alignment: Alignment.center,
                                  color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              double.parse(yearGP).isNaN
                                                  ? '0.00'
                                                  : yearGP,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            const Text('CGPA'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                  // color: Colors.blue,
                                  elevation: 0,
                                  itemBuilder: (_) => [
                                        PopupMenuItem(
                                          value: 'Clear CGPA Records',
                                          child: Text(
                                              'Clear Year ${index + 1} CGPA Records'),
                                        ),
                                      ],
                                  onSelected: (val) {
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60)),
                                              //backgroundColor: Colors.blue[900],
                                              title: const Text(
                                                'Clear all CGPA Record!',
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.red,
                                                    size: 70,
                                                  ),
                                                  Text(
                                                    'By confirming this, all your records for Year ${index + 1} GPA will be deleted',
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                IntrinsicHeight(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        GPCourseBloc>(
                                                                    context)
                                                                .add(
                                                              ClearYearRecord(
                                                                  'Year ${index + 1}'),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const FittedBox(
                                                            child: Text(
                                                              'Clear Records',
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          )),
                                                      const VerticalDivider(
                                                        color: Colors.white70,
                                                      ),
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child:
                                                              const FittedBox(
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ));
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          );
        }

        return const Center(
          child: Text(
              'something went wrong. Please refresh your network and try again'),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              //barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              isScrollControlled: true,
              context: context,
              builder: (context) => AddYearBottomSheet());
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}
