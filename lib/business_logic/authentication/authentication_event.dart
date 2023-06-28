import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

class LogOutRequest extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class UserChanged extends AuthenticationEvent {
  final User user;
  UserChanged(this.user);
  @override
  List<Object?> get props => [user];
}
