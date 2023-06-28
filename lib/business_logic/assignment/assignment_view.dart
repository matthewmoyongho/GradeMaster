// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'assignment_bloc.dart';
// import 'assignment_event.dart';
// import 'assignment_state.dart';
//
// class AssignmentPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => AssignmentBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<AssignmentBloc>(context);
//
//     return Container();
//   }
// }
//
