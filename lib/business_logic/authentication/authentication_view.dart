import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_acad/business_logic/password_reset/password_reset_cubit.dart';

import '../../app.dart';
import '../../data/repositories/assignment/assignment_repository.dart';
import '../../data/repositories/gp_course/gp_course_repository.dart';
import '../../data/repositories/timetable/timetable_repository.dart';
import '../../data/repositories/user_data/user_data_repository.dart';
import '../assignment/assignment_bloc.dart';
import '../assignment/timetable/timetable_bloc.dart';
import '../gp_course/gp_course_bloc.dart';
import '../login/login_cubit.dart';
import '../sign_up/sign_up_cubit.dart';
import '../user/user_cubit.dart';
import 'authentication_bloc.dart';

class AuthenticationWrapper extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  final AssignmentRepository _assignmentRepository;
  final GPCourseRepository _courseRepository;
  final TimeTableRepository _timeTableRepository;
  final UserDataRepository _userDataRepository;
  final bool showHome;

  AuthenticationWrapper({
    Key? key,
    required this.showHome,
    required AuthenticationRepository authenticationRepository,
    AssignmentRepository? assignmentRepository,
    TimeTableRepository? timeTableRepository,
    GPCourseRepository? gpCourseRepository,
    UserDataRepository? userDataRepository,
  })  : _userDataRepository = userDataRepository ??
            UserDataRepository(uid: authenticationRepository.currentUser.id),
        _authenticationRepository = authenticationRepository,
        _assignmentRepository = assignmentRepository ??
            AssignmentRepository(uid: authenticationRepository.currentUser.id),
        _courseRepository = gpCourseRepository ??
            GPCourseRepository(uid: authenticationRepository.currentUser.id),
        _timeTableRepository = timeTableRepository ??
            TimeTableRepository(uid: authenticationRepository.currentUser.id),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                authenticationRepository: _authenticationRepository),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(_authenticationRepository),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(_authenticationRepository),
          ),
          BlocProvider<PasswordResetCubit>(
            create: (context) => PasswordResetCubit(_authenticationRepository),
          ),
          BlocProvider<AssignmentBloc>(
            create: (context) =>
                AssignmentBloc(assignmentRepository: _assignmentRepository),
          ),
          BlocProvider<GPCourseBloc>(
              create: (context) =>
                  GPCourseBloc(gpCourseRepository: _courseRepository)),
          BlocProvider<TimetableBloc>(
              create: (context) =>
                  TimetableBloc(timetableRepository: _timeTableRepository)),
          BlocProvider<UserCubit>(
              create: (context) => UserCubit(
                  repository: _userDataRepository,
                  uid: _authenticationRepository.currentUser.id)),
        ],
        child: App(
          showHome: showHome,
        ),
      ),
    );
  }
}

// return MaterialApp(
//   theme: kTheme,
//   home: FlowBuilder<AuthenticationStatus>(
//     state:
//         context.select((AuthenticationBloc bloc) => bloc.state.authStatus),
//     onGeneratePages: onGeneratePages,
//   ),
//   routes: {
//     kSignUpScreenRoute: (context) => SignUpScreen(),
//     kSignInScreenRoute: (context) => SignInScreen(),
//     kOverviewScreenRoute: (context) => OverviewScreen(),
//     kSemesterScreenRoute: (context) => SemesterScreen(),
//     kYearScreenRoute: (context) => YearScreen(),
//     kGreatPointOverViewScreen: (context) => GreatPointOverViewScreen(),
//     kAssignmentScreen: (context) => AssignmentScreen(),
//     kClassesScreen: (context) => ClassesScreen(),
//     kTimeTableScreen: (context) => TimeTableScreen(),
//     kAssignmentDetailsScreen: (context) => AssignmentDetailsScreen(),
//     kProfileScreen: (context) => ProfileScreen(),
//     kNotificationScreen: (context) => NotificationScreen(),
//     kHome: (context) => Home(),
//     kResetPassword: (context) => ResetPassword(),
//   },
// );
