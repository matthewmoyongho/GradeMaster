import 'package:flutter/material.dart';

import '../../../business_logic/login/view/login_view.dart';

class SignInScreen extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: SignInScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
