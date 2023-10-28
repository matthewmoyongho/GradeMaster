import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../../constants.dart';
import '../../../sign_up/sign_up_cubit.dart';
import '../../../sign_up/sign_up_state.dart';
import '../../../user/user_cubit.dart';
import '../../login_cubit.dart';
import '../../login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ??
                    'An unknown error occurred! Please try again'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const _emailInput(),
            const SizedBox(
              height: 10,
            ),
            const _passwordInput(),
            const SizedBox(
              height: 20,
            ),
            const _forgotPasswordButton(),
            const SizedBox(
              height: 20,
            ),
            _loginButton(),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.blueGrey,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Or'),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.blueGrey,
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [_signInWithGoogle(), _registerButton()],
            )
          ],
        ),
      ),
    );
    ;
  }
}

class _emailInput extends StatelessWidget {
  const _emailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            key: const Key('Email_value_text_field'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                context.read<LoginCubit>().emailChanged(value),
            decoration: InputDecoration(
                errorText: state.emailInput.invalid ? 'Invalid email' : null,
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined)),
          );
        });
  }
}

class _passwordInput extends StatelessWidget {
  const _passwordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            key: const Key('Password_value_text_field'),
            textInputAction: TextInputAction.next,
            obscureText: state.showPassword,
            onChanged: (value) =>
                context.read<LoginCubit>().passwordChanged(value),
            decoration: InputDecoration(
              // errorText:
              //     state.passwordInput.invalid ? 'password invalid' : null,
              labelText: 'Password',
              prefixIcon: Icon(Icons.password_outlined),
              suffixIcon: GestureDetector(
                onTap: () => context.read<LoginCubit>().updateShowPassword(),
                child: Icon(
                  state.showPassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          );
        });
  }
}

// class _registerButton extends StatelessWidget {
//   _registerButton({Key? key}) : super(key: key);
//   final spinkit = SpinKitFadingCircle(
//     itemBuilder: (BuildContext context, int index) {
//       return DecoratedBox(
//         decoration: BoxDecoration(
//           color: index.isEven ? Colors.red : Colors.blue[900],
//         ),
//       );
//     },
//   );
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//         buildWhen: (previous, current) => previous != current,
//         builder: (context, state) {
//           return state.status.isSubmissionInProgress
//               ? spinkit
//               : ElevatedButton(
//                   key: const Key('Submit_value_text_field'),
//                   onPressed: state.status.isValidated
//                       ? () async {
//                           print(state.nameInput.value.trim());
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           final user =
//                               await context.read<SignUpCubit>().singUp();
//                           if (user != null) {
//                             final userDetails = UserData(
//                                 gpTarget: 'NOT SET',
//                                 phone: '',
//                                 school: '',
//                                 year: 0,
//                                 name: state.nameInput.value.toString().trim());
//                             context
//                                 .read<UserCubit>()
//                                 .setUserData(user.uid, userDetails);
//                           }
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                       fixedSize: Size(MediaQuery.of(context).size.width, 20)),
//                   child: const Text(
//                     'Register',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 );
//         });
//   }
// }

class _loginButton extends StatelessWidget {
  _loginButton({Key? key}) : super(key: key);
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.blue[900],
        ),
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? spinkit
              : ElevatedButton(
                  key: const Key('Login_value_text_field'),
                  onPressed: state.status.isValidated
                      ? () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<LoginCubit>().login();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(MediaQuery.of(context).size.width, 25),
                      padding: const EdgeInsets.all(8)),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                );
        });
  }
}

class _registerButton extends StatelessWidget {
  const _registerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, present) => previous != present,
        builder: (context, state) {
          if (state.status.isSubmissionInProgress) return SizedBox.shrink();
          return ElevatedButton(
            key: const Key('Sign_up_instead_value_text_field'),
            onPressed: () =>
                Navigator.of(context).pushNamed(kSignUpScreenRoute),
            child: Text(
              'Sign Up instead ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(8)),
          );
        });
  }
}

class _forgotPasswordButton extends StatelessWidget {
  const _forgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, present) => previous != present,
        builder: (context, state) {
          if (state.status.isSubmissionInProgress) return SizedBox.shrink();
          return Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: TextButton(
              key: const Key('forgot_password_value_text_field'),
              onPressed: () => Navigator.of(context).pushNamed(kResetPassword),
              child: Text(
                'Forgot password?',
                style: TextStyle(
                    color: kDarkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}

class _signInWithGoogle extends StatelessWidget {
  const _signInWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, present) => previous != present,
        builder: (context, state) {
          if (state.status.isSubmissionInProgress) return SizedBox.shrink();
          return ElevatedButton.icon(
            key: const Key('_signInWithGoogle_value_text_field'),
            onPressed: () async {
              final user = await context.read<LoginCubit>().googleSignIn();

              if (user != null) {
                final userDetails = UserData(
                    gpTarget: 'NOT SET',
                    phone: '',
                    school: '',
                    year: 0,
                    name: user.displayName);
                context.read<UserCubit>().setUserData(user.uid, userDetails);
              }
            },
            icon: Icon(FontAwesomeIcons.google),
            label: Text(
              'Sign In with google',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(8)),
          );
        });
  }
}
