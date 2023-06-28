import 'package:flutter/material.dart';

import '../../constants.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool loading = false;

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    // final courses = Provider.of<GPCourses>(context, listen: false);
    // final ass = Provider.of<Assignments>(context, listen: false);
    // final db = Provider.of<DatabaseServices>(context, listen: false);

    try {
      // await courses.getOverallGPCourses();
      // await courses.fetchNumberOfYears();
      // await ass.fetchAssignments();
      // await db.getUser();
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loading = false;
    });
    Navigator.of(context).pushReplacementNamed(kOverviewScreenRoute);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[900],
        width: double.infinity,
        child: loading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Give me few seconds to fetch your records',
                    style: TextStyle(
                        color: Colors.white70, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                ],
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
