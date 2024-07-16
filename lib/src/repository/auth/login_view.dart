import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidvibe/src/repository/auth/auth_cubit/auth_cubit.dart';
import 'package:vidvibe/src/repository/auth/profile/profile_view.dart';
import 'package:vidvibe/src/repository/auth/register_view.dart';
import 'package:vidvibe/src/repository/auth/widgets/text_fieled.dart';
import 'package:vidvibe/src/repository/classes/repository_text.dart';
import 'package:vidvibe/src/repository/home/home_view.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

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
                builder: (context) => const HomeView(),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is UserDataLoaded) {
            if (state.userData.isNotEmpty) {
              final user = state.userData.first;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(
                    username: user['username'],
                    email: user['email'],
                  ),
                ),
              );
            }
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
                      RepositoryText.logintext,
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        context.read<AuthCubit>().logIn(email, password);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: h * 0.03,
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
                          'If you don\'t have an account then',
                          style: TextStyle(fontSize: h * 0.016),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterView(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: h * 0.018,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
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
