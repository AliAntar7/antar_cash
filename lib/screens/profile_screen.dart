import 'package:antar_cash/cubit/profile_cubit/profile_cubit.dart';
import 'package:antar_cash/cubit/profile_cubit/profile_states.dart';
import 'package:antar_cash/screens/login_screen.dart';
import 'package:antar_cash/widgets/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserFromFireStore(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if(state is UserDataLoadingToUpdate)
          {

          }else if(state is UserDataUpdated)
          {
            showSnackBar(
              context,
              'Your data is updated Successfully',
              Colors.green,
            );
          }else if(state is UserDataUpdateError)
          {
            showSnackBar(
              context,
              'Please enter correct data',
              Colors.red,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileSuccess) {
            email.text = state.userModel.email;
            name.text = state.userModel.name;
            phone.text = state.userModel.phone;
            password.text = state.userModel.password;
            return Scaffold(
              appBar: AppBar(
                elevation: 3,
                title: Text(
                  'Your Profile',
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.grey[500],
                          radius: 50,
                          backgroundColor: Colors.yellow[300],
                          child: const Icon(
                            Icons.person,
                            size: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: name,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
                            hintText: 'name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.yellow,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 25,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
                            hintText: 'email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.yellow,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 25,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phone,
                          cursorColor: Colors.yellow,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'phone',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.yellow,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(
                              Icons.phone,
                              size: 25,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone number can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
                            hintText: 'password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.yellow,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(
                              Icons.password,
                              size: 25,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut().then((a) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('logout successfully.'),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is UserDataLoadingToUpdate ? Center(child: Container(
                          color: Colors.red,
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(),
                        ),
                        ) : ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await context.read<ProfileCubit>().updateUserData(
                                name: name.text,
                                email: email.text,
                                phone: phone.text,
                                password: password.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            backgroundColor: Colors.green[500],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
