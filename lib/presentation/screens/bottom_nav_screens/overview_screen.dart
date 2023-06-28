import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_acad/presentation/screens/bottom_nav_screens/profile.dart';

import '../../../../business_logic/assignment/assignment_bloc.dart';
import '../../../../business_logic/assignment/assignment_event.dart';
import '../../../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../../../business_logic/assignment/timetable/timetable_event.dart';
import '../../../../business_logic/gp_course/gp_course_bloc.dart';
import '../../../../business_logic/gp_course/gp_course_event.dart';
import '../../../../business_logic/user/user_cubit.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'great_point_overview_screen.dart';
import 'home.dart';
import 'notification_screen.dart';

class OverviewScreen extends StatefulWidget {
  static Page page() => MaterialPage<void>(child: OverviewScreen());
  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int currentIndex = 0;

  void onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  void homeTab() {
    setState(() {
      currentIndex = 1;
    });
  }

  List navScreens = [
    Home(),
    GreatPointOverViewScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    BlocProvider.of<TimetableBloc>(context).add(LoadTimetable());
    BlocProvider.of<AssignmentBloc>(context).add(LoadAssignments());
    if (FirebaseAuth.instance.currentUser != null) {
      BlocProvider.of<UserCubit>(context)
          .loadUserData(FirebaseAuth.instance.currentUser!.uid);
    }
    BlocProvider.of<GPCourseBloc>(context).add(LoadGPCourses());
    // final fcm = FirebaseMessaging.instance;
    // fcm.requestPermission();
    // fcm.c
    FirebaseMessaging.instance.getInitialMessage().then((value) => null);
    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final route = message.data['route'];
      print(route);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue[900],
        //statusBarColor: Colors.blue[900],
      ),
    );
    return Container(
      color: Colors.blue[900],
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.zero,
            child: AppBar(
              elevation: 0,
            ),
          ),
          drawer: const AppDrawer(),
          body: navScreens[currentIndex],
          bottomNavigationBar: BottomNavBar(onTap, currentIndex),
        ),
      ),
    );
  }
}
