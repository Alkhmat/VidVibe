import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidvibe/src/repository/auth/auth_cubit/auth_cubit.dart';

import 'package:vidvibe/src/repository/auth/profile/profile_view.dart';
import 'package:vidvibe/src/repository/auth/widgets/text_fieled.dart';
import 'package:vidvibe/src/repository/home/home_view.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(right: 340, top: 20),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileView(
                  username: state.user.username,
                  email: state.user.email,
                ),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: h * 0.3,
                    ),
                    Text(
                      'Registration',
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomTextFieled(
                      obscureText: false,
                      label: 'User name',
                      controller: _usernameController,
                      icon: const Icon(Icons.person),
                    ),
                    CustomTextFieled(
                      obscureText: false,
                      label: 'Email address',
                      controller: _emailController,
                      icon: const Icon(Icons.alternate_email_outlined),
                    ),
                    CustomTextFieled(
                      obscureText: true,
                      label: 'Password',
                      icon: const Icon(Icons.password_outlined),
                      controller: _passwordController,
                    ),
                    SizedBox(height: h * 0.01),
                    TextButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final username = _usernameController.text;
                        context
                            .read<AuthCubit>()
                            .signUp(email, password, username);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: h * 0.023,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'If you have an existing account ',
                          style: TextStyle(fontSize: h * 0.016),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogInView(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: h * 0.018,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
