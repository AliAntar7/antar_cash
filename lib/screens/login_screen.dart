import 'package:antar_cash/cubit/login_cubit/login_cubit.dart';
import 'package:antar_cash/cubit/login_cubit/login_states.dart';
import 'package:antar_cash/screens/home_screen.dart';
import 'package:antar_cash/screens/register_screen.dart';
import 'package:antar_cash/widgets/my_form_field.dart';
import 'package:antar_cash/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoading) {
          } else if (state is LoginSuccess) {
            showSnackBar(context, 'User logged in successfully.', Colors.green);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
                  (route) => false,
            );
          } else if (state is LoginError) {
            showSnackBar(context, state.message, Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Image.asset('assets/images/chat.png',
                          width: 150, height: 150),
                      const SizedBox(height: 10),
                      const Text(
                        'Viva Chat',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlayWrite',
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Login your account',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      MyFormField(
                        onChanged: (data) {
                          emailController.text = data;
                          return null;
                        },
                        controller: emailController,
                        hintText: 'Enter your email',
                        label: 'Email',
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          RegExp emailRegExp = RegExp(r'^[\w-]+@[a-zA-Z\d-]+\.(com)$');
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter correct email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyFormField(
                        onChanged: (data) {
                          passwordController.text = data;
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        hintText: 'Enter your password',
                        label: 'Password',
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      state is LoginLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().loginUser(
                                emailController: emailController.text,
                                passwordController:
                                passwordController.text);
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
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 3,
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
