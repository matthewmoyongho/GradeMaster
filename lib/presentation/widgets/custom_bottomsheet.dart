import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../business_logic/assignment/timetable/timetable_event.dart';
import '../../business_logic/assignment/timetable/timetable_state.dart';
import '../../data/models/time_table_course.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List times = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24
  ];

  // String code = '';

  String day = '';

  //String startTime = '';

  //String endTime = '';
  // String title = '';

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _stopTController = TextEditingController();
  TimeOfDay startTime = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay stopTime = const TimeOfDay(hour: 00, minute: 00);
  void showAlertDialog(BuildContext context, String message) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              backgroundColor: Colors.blue[900],
              title: const Text(
                'An error occurred!',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 70,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final authProvider = Provider.of<AuthServices>(context);
    //final db = Provider.of<DatabaseServices>(context, listen: false);
    return makeDismissible(
      DraggableScrollableSheet(
        initialChildSize: .6,
        maxChildSize: .8,
        minChildSize: .4,
        builder: (context, draggableController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView(controller: draggableController, children: [
              const Text(
                'Add to your timetable',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              // TextFormField(
              //
              // ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _codeController,
                key: const ValueKey('code'),
                maxLength: 10,
                decoration: const InputDecoration(
                  label: Text(
                    'Course code',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _titleController,
                maxLength: 50,
                key: const ValueKey('title'),
                decoration: const InputDecoration(
                  label: Text(
                    'Course title',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                key: const ValueKey('day'),
                //value: day,
                decoration: const InputDecoration(
                    label: Text(
                  'Select day',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                )),
                items: days
                    .map((day) => DropdownMenuItem(
                          value: day,
                          child: Text(day),
                        ))
                    .toList(),
                onChanged: (val) {
                  day = val!.toString();
                },
                onSaved: (val) {
                  day = val!.toString();
                },
              ),
              //TextFormField(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Start time'),
                        TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          decoration: const InputDecoration(
                              hintText: 'Pick a Time',
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () => _selectStartTime(context),
                          controller: _startTimeController,
                        ),
                        // DropdownButtonFormField(
                        //   key: const ValueKey('start'),
                        //   //value: startTime,
                        //   items: times
                        //       .map((time) => DropdownMenuItem(
                        //             child: Text(time.toString()),
                        //             value: time,
                        //           ))
                        //       .toList(),
                        //   onChanged: (val) {
                        //     startTime = val!.toString();
                        //   },
                        //   onSaved: (val) {
                        //     startTime = val!.toString();
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Stop time'),
                        TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          decoration: const InputDecoration(
                              hintText: 'Pick a Time',
                              border: OutlineInputBorder()),
                          readOnly: true,
                          onTap: () => _selectStopTime(context),
                          controller: _stopTController,
                        ),
                        // DropdownButtonFormField(
                        //   key: const ValueKey('end'),
                        //   //value: endTime,
                        //   items: times
                        //       .map((time) => DropdownMenuItem(
                        //             child: Text(time.toString()),
                        //             value: time,
                        //           ))
                        //       .toList(),
                        //   onChanged: (val) {
                        //     endTime = val!.toString();
                        //   },
                        //   onSaved: (val) {
                        //     endTime = val!.toString();
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<TimetableBloc, TimetableState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(deviceSize.width * 0.3, 40),
                            primary: Colors.blue[900]),
                        onPressed: () {
                          TimeTableCourse course = TimeTableCourse(
                            courseCode:
                                _codeController.text.trim().toUpperCase(),
                            day: day,
                            startTime: int.parse(
                                '${startTime.hour}${startTime.minute}'),
                            stopTime:
                                int.parse('${stopTime.hour}${stopTime.minute}'),
                            title: _titleController.text.trim(),
                          );
                          try {
                            context
                                .read<TimetableBloc>()
                                .add(AddTimetableCourse(course));
                            Navigator.pop(context);
                          } catch (e) {
                            showAlertDialog(context,
                                'Could not add to add to timetable. Please try again');
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(deviceSize.width * 0.3, 40),
                          primary: Colors.blue[900]),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
        _startTimeController.text = pickedTime.format(context).toString();
        if (pickedTime.hour.toInt() > stopTime.hour.toInt()) {
          _stopTController.text = '';
          stopTime = TimeOfDay(hour: 23, minute: 59);
        }
      });
    }
  }

  Future<Null> _selectStopTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
      hourLabelText: 'H',
      minuteLabelText: 'M',
    );
    if (pickedTime!.hour.toInt() <= startTime.hour.toInt()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Stop time cannot be less than the start time'),
      ));
      pickedTime = null;
    }
    if (pickedTime != null) {
      setState(() {
        stopTime = pickedTime!;
        _stopTController.text = pickedTime.format(context).toString();
      });
    }
  }

  Widget makeDismissible(Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
