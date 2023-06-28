import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/user/user_cubit.dart';
import '../../business_logic/user/user_state.dart';

class AddYearBottomSheet extends StatefulWidget {
  @override
  State<AddYearBottomSheet> createState() => _AddYearBottomSheet();
}

class _AddYearBottomSheet extends State<AddYearBottomSheet> {
  late String years;
  late String selectedYear;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        years = state.year.toString();

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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: ListView(controller: draggableController, children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Add Year',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  DropdownButtonFormField(
                    key: const ValueKey('year'),
                    //value: day,
                    decoration: const InputDecoration(
                        label: Text(
                      'Select year',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    )),
                    items: List.generate(int.parse(years) + 1,
                            (index) => 'Year ${index + 1}')
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ))
                        .toList(),
                    onChanged: (val) {
                      selectedYear = val!.toString();
                    },
                    onSaved: (val) {
                      selectedYear = val!.toString();
                    },
                  ),

                  //TextFormField(),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(deviceSize.width * 0.3, 40),
                            primary: Colors.blue[900]),
                        onPressed: () async {
                          context.read<UserCubit>().updateUserData(
                              UserData(year: int.parse(years) + 1));
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(deviceSize.width * 0.3, 40),
                            primary: Colors.blue[900]),
                        onPressed: () {},
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
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
