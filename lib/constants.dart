//My routes constants

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String kOverviewScreenRoute = 'overviewScreen';
const String kSemesterScreenRoute = 'SemesterScreen';
const String kYearScreenRoute = 'YearScreen';
const String kSignInScreenRoute = 'SignInScreen';
const String kSignUpScreenRoute = 'SignUpScreen';
const String kGreatPointOverViewScreen = 'GreatPointOverViewScreen';
const String kAssignmentScreen = 'AssignmentScreen';
const String kClassesScreen = 'ClassesScreen';
const String kTimeTableScreen = 'kTimetableScreen';
const String kAssignmentDetailsScreen = 'AssignmentDetailsScreen';
const String kProfileScreen = 'ProfileScreen';
const String kNotificationScreen = 'NotificationScreen';
const String kHome = 'Home';
const String kResetPassword = 'ResetPassword';

// formatted dates
String kToday = DateFormat('EEEE').format(DateTime.now());
String kMonth = DateFormat('MMM').format(DateTime.now());
String kDate = DateFormat('d').format(DateTime.now());

final kMyGradeUsersCollection = FirebaseFirestore.instance.collection('Users');

const Color kDarkBlue = Color(0xFF0D47A1);
const Color kPeachOrange = Color(0XFFFFC299);

List<Map> kOnBoardingContents = [
  {
    'picture': 'assets/exam.png',
    'title': 'Save your grades to the cloud',
    'body':
        'You can have access to your grades no matter where you are. your CGPA gets calculated automatically for you.'
  },
  {
    'picture': 'assets/class.png',
    'title': 'Save you semester timetable to the cloud',
    'body':
        'You get notifications your schedule for the day base on your timetable so you never get to miss a class unintentionally'
  },
  {
    'picture': 'assets/assignment.png',
    'title': 'Save your class assignment and other task to the cloud',
    'body':
        'You can have access to your Assignment anywhere and also get reminders for your undone task and assignment.'
  },
];

//Material app theme

final kTheme = ThemeData(
  primaryColor: Colors.blue[900],
  //primarySwatch: Color(0xFF0D47A1)!,
  inputDecorationTheme: InputDecorationTheme(
    focusColor: kDarkBlue,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: kDarkBlue,
        width: 2,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: kDarkBlue,
        width: 3,
      ),
    ),
    prefixIconColor: kDarkBlue,
    suffixIconColor: kDarkBlue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 2),
      onPrimary: Colors.white70,
      primary: Colors.blue[900],
    ),
  ),
);
