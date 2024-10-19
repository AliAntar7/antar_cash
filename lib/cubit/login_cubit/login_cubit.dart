import 'package:antar_cash/cubit/login_cubit/login_states.dart';
import 'package:antar_cash/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInit());

  Future<void> loginUser({
    required String emailController,
    required String passwordController,
  }) async {
    emit(LoginLoading());
    try {
      // Check if the user exists in the Firestore database
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailController)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // If no user is found, emit an error state
        emit(LoginError(message: "User not found in the database"));
        return;
      }

      // If the user exists, get the user's data
      Map<String, dynamic>? data = querySnapshot.docs.first.data();
      final userData = UserModel.fromJson(data);

      // Proceed with Firebase Authentication
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      // Emit success states
      emit(LoginSuccess(loginEmail: emailController));
      emit(CheckUserSuccess(user: userData));
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific authentication errors
      emit(LoginError(message: e.message ?? "Authentication failed"));
    } catch (e) {
      // Handle any other errors
      emit(LoginError(message: e.toString()));
    }
  }

}