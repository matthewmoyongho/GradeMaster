import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Exit app?'),
                      content: Text('Press \'OK\' to confirm'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('OK')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel')),
                      ],
                    )) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0,
          title: Text('Notifications'),
        ),
        drawer: const AppDrawer(),
        body: Center(
          child: Text('No new notifications'),
        ),
      ),
    );
  }
}
