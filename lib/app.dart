import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_acad/presentation/screens/assignment_details_screen.dart';
import 'package:my_acad/presentation/screens/assignment_screen.dart';
import 'package:my_acad/presentation/screens/authentication/sign_in.dart';
import 'package:my_acad/presentation/screens/authentication/sign_up.dart';
import 'package:my_acad/presentation/screens/bottom_nav_screens/great_point_overview_screen.dart';
import 'package:my_acad/presentation/screens/bottom_nav_screens/home.dart';
import 'package:my_acad/presentation/screens/bottom_nav_screens/notification_screen.dart';
import 'package:my_acad/presentation/screens/bottom_nav_screens/overview_screen.dart';
import 'package:my_acad/presentation/screens/bottom_nav_screens/profile.dart';
import 'package:my_acad/presentation/screens/classes_screen.dart';
import 'package:my_acad/presentation/screens/great_point/semester.dart';
import 'package:my_acad/presentation/screens/great_point/year.dart';
import 'package:my_acad/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:my_acad/presentation/screens/timetable_screen.dart';

import 'business_logic/authentication/authentication_bloc.dart';
import 'business_logic/authentication/authentication_state.dart';
import 'constants.dart';

class App extends StatelessWidget {
  final bool showHome;
  const App({Key? key, required this.showHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kTheme,
      home: showHome
          ? BlocBuilder<AuthenticationBloc, AuthenticationState>(
              buildWhen: (previous, current) => previous != current,
              builder: (ctx, state) {
                if (state.authStatus == AuthenticationStatus.authenticated) {
                  return OverviewScreen();
                } else {
                  return SignInScreen();
                }
              },
            )
          : OnBoardingScreen(),
      routes: {
        kSignUpScreenRoute: (context) => SignUpScreen(),
        kSignInScreenRoute: (context) => SignInScreen(),
        kOverviewScreenRoute: (context) => OverviewScreen(),
        kSemesterScreenRoute: (context) => SemesterScreen(),
        kYearScreenRoute: (context) => YearScreen(),
        kGreatPointOverViewScreen: (context) => GreatPointOverViewScreen(),
        kAssignmentScreen: (context) => AssignmentScreen(),
        kClassesScreen: (context) => ClassesScreen(),
        kTimeTableScreen: (context) => TimeTableScreen(),
        kAssignmentDetailsScreen: (context) => AssignmentDetailsScreen(),
        kProfileScreen: (context) => ProfileScreen(),
        kNotificationScreen: (context) => NotificationScreen(),
        kHome: (context) => Home(),
        //kResetPassword: (context) => ResetPassword(),
      },
    );
  }
}

List<Page> onGeneratePages(
    AuthenticationStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [OverviewScreen.page()];
    case AuthenticationStatus.unAuthenticated:
      return [SignInScreen.page()];
  }
}
