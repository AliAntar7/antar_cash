import 'package:antar_cash/cubit/register_cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInit());

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoading());
    try {
      final user = FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((v) async {

        if (v.user != null) {
          await FirebaseFirestore.instance.collection('users').doc(v.user?.uid).set({
            'name': name,
            'phone': phone,
            'email': email,
            'password': password,
            'uid': v.user!.uid,
          });
          emit(RegisterSuccess());
        } else {
          throw Exception('error');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterError(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterError(
            message: 'The account already exists for that email.'));
      } else {
        emit(RegisterError(message: e.message!));
      }
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}
