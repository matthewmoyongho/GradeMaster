import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_acad/business_logic/gp_course/gp_course_event.dart';

import '../../../business_logic/gp_course/gp_course_bloc.dart';
import '../../widgets/add_gp_course_bottomsheet.dart';
import '../../widgets/first_semester_tab.dart';
import '../../widgets/second_semester_tab.dart';

class SemesterScreen extends StatefulWidget {
  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadedYear = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text(loadedYear),
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
                            'Clear CGPA Record?',
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
                                'By confirming this, all your GPA records for this semester will be deleted',
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
                                        BlocProvider.of<GPCourseBloc>(context)
                                            .add(ClearSemesterRecord(
                                          year: loadedYear,
                                          semester: _tabController.index == 0
                                              ? 'First Semester'
                                              : 'Second Semester',
                                        ));
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
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'First Semester',
          ),
          Tab(
            text: 'Second Semester',
          ),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FirstSemesterTab(
            loadedYear,
          ),
          SecondSemesterTab(
            loadedYear,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            //barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            isScrollControlled: true,
            context: context,
            builder: (context) => AddGPCourseBottomSheet(
                year: loadedYear,
                semester: _tabController.index == 0
                    ? 'First Semester'
                    : 'Second Semester'),
          );
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}
