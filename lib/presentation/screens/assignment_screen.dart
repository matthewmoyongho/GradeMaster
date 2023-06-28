import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/assignment/assignment_bloc.dart';
import '../../business_logic/assignment/assignment_state.dart';
import '../../data/models/assignment.dart';
import '../widgets/assignment_bottomsheet.dart';
import '../widgets/assignment_tile.dart';

class AssignmentScreen extends StatelessWidget {
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    label: Text(
                      'Go back',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'MY ASSIGNMENTS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
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
                  height: deviceSize.height * 0.75,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(
                    children: [
                      Container(
                        height: deviceSize.height * .55,
                        child: AssignmentsView(),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              //barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              isScrollControlled: true,
              context: context,
              builder: (context) => AssignmentBottomSheet());
        },
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add),
      ),
    );
  }
}

class AssignmentsView extends StatelessWidget {
  const AssignmentsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentBloc, AssignmentState>(
      builder: (context, state) {
        List<Assignment> assignments = [];
        if (state is AssignmentsLoading) {
          return Container(
            height: 100,
            width: double.infinity,
            child: const Center(
              child: Text('Loading Assignments'),
            ),
          );
        }
        if (state is AssignmentsLoaded) {
          assignments.addAll(state.assignments);

          return assignments.isNotEmpty
              ? ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    return AssignmentTile(
                      assignment: assignments[index],
                    );
                  })
              : Container(
                  height: 100,
                  width: double.infinity,
                  child: const Center(
                    child: Text('No new assignment'),
                  ),
                );
        }
        return Container(
          height: 100,
          width: double.infinity,
          child: const Center(
            child: Text('Oops!!! Could not load your Assignments!',
                softWrap: true),
          ),
        );
      },
    );
  }
}
