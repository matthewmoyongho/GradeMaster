import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthenticationState.authenticated(
                authenticationRepository.currentUser,
              )
            : AuthenticationState.unAuthenticated()) {
    on<UserChanged>(_userChanged);
    on<LogOutRequest>(_logOut);
    _userSubscription = _authenticationRepository.user.listen((user) {
      add(
        UserChanged(user),
      );
    });
  }

  void _userChanged(UserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthenticationState.authenticated(event.user)
          : AuthenticationState.unAuthenticated(),
    );
  }

  void _logOut(LogOutRequest event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationRepository.logOut());
  }
}
