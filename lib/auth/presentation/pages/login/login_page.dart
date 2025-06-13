import 'package:f_bloc/auth/presentation/bloc/auth_bloc.dart';
import 'package:f_bloc/auth/presentation/pages/home/home_page.dart';
import 'package:f_bloc/auth/presentation/widgets/gradient_button.dart';
import 'package:f_bloc/auth/presentation/widgets/login_field.dart';
import 'package:f_bloc/auth/presentation/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }

          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/image/signin_balls.png'),
                  const Text(
                    'Sign in.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  const SizedBox(height: 50),
                  const SocialButton(
                    iconPath: 'assets/svg/g_logo.svg',
                    label: 'Continue with Google',
                    horizontalPadding: 100.0,
                  ),
                  const SizedBox(height: 20),
                  const SocialButton(
                    iconPath: 'assets/svg/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 90.0,
                  ),
                  const SizedBox(height: 15),
                  const Text('or', style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 15),
                  LoginField(hintText: 'Email', controller: emailController),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  SizedBox(height: 20),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthLoginRequested(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
