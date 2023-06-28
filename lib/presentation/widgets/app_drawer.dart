import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/authentication/authentication_bloc.dart';
import '../../constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Drawer(
      // backgroundColor: Colors.blue[900],
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue[900],
                    backgroundImage: user.photoUrl != null
                        ? NetworkImage(user.photoUrl!)
                        : null,
                    child: user.photoUrl == null
                        ? const Icon(
                            Icons.person,
                            size: 35,
                          )
                        : null,
                  ),
                ),
                Center(
                  child: Text(
                    '${user.email}',
                    style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(kTimeTableScreen);
              },
              title: Text(
                'Timetable',
                style: TextStyle(fontSize: 20, color: Colors.blue[900]),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(kClassesScreen);
              },
              title: Text(
                'Classes',
                style: TextStyle(fontSize: 20, color: Colors.blue[900]),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(kAssignmentScreen);
              },
              title: Text(
                'Assignment',
                style: TextStyle(fontSize: 20, color: Colors.blue[900]),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(kYearScreenRoute);
              },
              title: Text(
                'Years',
                style: TextStyle(fontSize: 20, color: Colors.blue[900]),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.login_outlined,
                color: Colors.blue[900],
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20, color: Colors.blue[900]),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Sign Out?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () => FirebaseAuth.instance.signOut(),
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('No'),
                            ),
                          ],
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
