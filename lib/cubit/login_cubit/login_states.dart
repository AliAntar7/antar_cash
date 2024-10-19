import 'package:antar_cash/models/user_model.dart';

abstract class LoginStates{}

class LoginLoading extends LoginStates {}
class LoginInit extends LoginStates {}
class LoginSuccess extends LoginStates {
  final String loginEmail;
  LoginSuccess({required this.loginEmail});
}
class CheckUserLoading extends LoginStates {}
class CheckUserSuccess extends LoginStates {
  final UserModel user;
  CheckUserSuccess({required this.user});
}
class CheckUserError extends LoginStates {
  final String message;
  CheckUserError({required this.message});
}
class LoginError extends LoginStates {
  final String message;
  LoginError({required this.message});
}