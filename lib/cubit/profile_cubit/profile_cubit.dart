import 'package:antar_cash/cubit/profile_cubit/profile_states.dart';
import 'package:antar_cash/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInit());

  Future<void> getUserFromFireStore() async {
    try {
      emit(ProfileLoading());
      final uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      Map<String, dynamic>? data =  doc.data();
      final user = UserModel.fromJson(data!);
      emit(ProfileSuccess(user));
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
    required String password,
}) async {
    emit(UserDataLoadingToUpdate());
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );
      emit(UserDataUpdated());
      await getUserFromFireStore();
    } on Exception catch (e) {
      emit(UserDataUpdateError(message: e.toString()));
    }
  }
}
