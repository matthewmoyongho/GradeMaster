import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';

import '../../../../constants.dart';
import '../../../user/user_cubit.dart';
import '../../sign_up_cubit.dart';
import '../../sign_up_state.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

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
            Text(
              'Register',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            _nameInput(),
            const SizedBox(
              height: 10,
            ),
            _emailInput(),
            const SizedBox(
              height: 10,
            ),
            _passwordInput(),
            const SizedBox(
              height: 20,
            ),
            _registerButton(),
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const _loginButton()
          ],
        ),
      ),
    );
  }
}

class _nameInput extends StatelessWidget {
  const _nameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            key: const Key('Name_value_text_field'),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onChanged: (value) =>
                context.read<SignUpCubit>().nameChanged(value),
            decoration: InputDecoration(
                errorText:
                    state.nameInput.invalid ? 'Name cannot be empty' : null,
                labelText: 'Name',
                prefixIcon: Icon(Icons.account_circle)),
          );
        });
  }
}

class _emailInput extends StatelessWidget {
  const _emailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            key: const Key('Email_value_text_field'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                context.read<SignUpCubit>().emailChanged(value),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return TextField(
            key: const Key('Password_value_text_field'),
            textInputAction: TextInputAction.next,
            obscureText: state.showPassword,
            onChanged: (value) =>
                context.read<SignUpCubit>().passwordChanged(value),
            decoration: InputDecoration(
              errorText:
                  state.passwordInput.invalid ? 'password invalid' : null,
              labelText: 'Password',
              prefixIcon: Icon(Icons.password_outlined),
              suffixIcon: GestureDetector(
                onTap: () => context.read<SignUpCubit>().updateShowPassword(),
                child: Icon(
                  state.showPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          );
        });
  }
}

class _registerButton extends StatelessWidget {
  _registerButton({Key? key}) : super(key: key);
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
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? spinkit
              : ElevatedButton(
                  key: const Key('Submit_value_text_field'),
                  onPressed: state.status.isValidated
                      ? () async {
                          print(state.nameInput.value.trim());
                          FocusManager.instance.primaryFocus?.unfocus();
                          final user =
                              await context.read<SignUpCubit>().singUp();
                          if (user != null) {
                            final userDetails = UserData(
                                gpTarget: 'NOT SET',
                                phone: '',
                                school: '',
                                year: 0,
                                name: state.nameInput.value.toString().trim());
                            context
                                .read<UserCubit>()
                                .setUserData(user.uid, userDetails);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 20)),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                );
        });
  }
}

class _loginButton extends StatelessWidget {
  const _loginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, present) => previous != present,
        builder: (context, state) {
          if (state.status.isSubmissionInProgress)
            return const SizedBox.shrink();
          return TextButton(
            key: const Key('Login_instead_value_text_field'),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed(kSignInScreenRoute),
            child: const Text(
              'Already have an account? Login ',
              style: TextStyle(
                  color: kDarkBlue, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
