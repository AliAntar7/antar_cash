import 'package:antar_cash/cubit/register_cubit/register_cubit.dart';
import 'package:antar_cash/cubit/register_cubit/register_states.dart';
import 'package:antar_cash/screens/home_screen.dart';
import 'package:antar_cash/screens/login_screen.dart';
import 'package:antar_cash/widgets/my_form_field.dart';
import 'package:antar_cash/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterLoading) {
          } else if (state is RegisterSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(),
              ),
                  (route) => false,
            );
            showSnackBar(
                context, 'User registered successfully.', Colors.green);
          } else if (state is RegisterError) {
            showSnackBar(context, state.message, Colors.red);
          }
        },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Register'),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                        'assets/images/chat.png', width: 150, height: 150),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Viva Chat',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayWrite',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    MyFormField(
                      controller: name,
                      hintText: 'Enter your name',
                      label: 'Name',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                        height: 10),
                    MyFormField(
                      controller: phone,
                      hintText: 'Enter your phone number',
                      label: 'Phone Number',
                      prefixIcon: Icons.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                        height: 10),
                    MyFormField(
                      onChanged: (data) {
                        email.text = data;
                        return null;
                      },
                      controller: email,
                      hintText: 'Enter your email',
                      label: 'Email',
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyFormField(
                      onChanged: (data) {
                        password.text = data;
                        return null;
                      },
                      controller: password,
                      hintText: 'Enter your password',
                      label: 'Password',
                      obscureText: true,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    state is RegisterLoading ? const Center(
                      child: CircularProgressIndicator(),
                    ) : ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<RegisterCubit>().register(
                            email: email.text,
                            password: password.text,
                            name: name.text,
                            phone: phone.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      ),
    );
  }
}
