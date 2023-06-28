import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

enum AuthenticationStatus { authenticated, unAuthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus authStatus;
  final User user;
  final UserData? userData;
  const AuthenticationState._(
      {required this.authStatus, this.user = User.empty, this.userData});

  AuthenticationState.authenticated(User user)
      : this._(
            user: user,
            //userData: userData,
            authStatus: AuthenticationStatus.authenticated);
  AuthenticationState.unAuthenticated()
      : this._(authStatus: AuthenticationStatus.unAuthenticated);

  @override
  List<Object?> get props => [authStatus, user, userData];
}
