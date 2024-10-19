import 'package:antar_cash/models/user_model.dart';

abstract class ProfileStates {}

class ProfileInit extends ProfileStates {}
class ProfileLoading extends ProfileStates {}
class UserDataLoadingToUpdate extends ProfileStates {}
class UserDataUpdateError extends ProfileStates {
  final String message;
  UserDataUpdateError({required this.message});
}
class UserDataUpdated extends ProfileStates {}
class ProfileSuccess extends ProfileStates {
  final UserModel userModel;
  ProfileSuccess(this.userModel);
}
class ProfileError extends ProfileStates {
  final String message;
  ProfileError({required this.message});
}
