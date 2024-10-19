abstract class RegisterStates{}


class RegisterInit extends RegisterStates{}
class RegisterLoading extends RegisterStates {}
class RegisterSuccess extends RegisterStates {}
class RegisterError extends RegisterStates {
  final String message;
  RegisterError({required this.message});
}