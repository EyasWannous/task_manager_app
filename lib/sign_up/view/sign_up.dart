import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';
import 'package:task_manager_app/sign_up/cubit/sign_up_cubit.dart';
import 'package:task_manager_app/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
            context.read<InternetAuthentication>(),
            context.read<AppBloc>(),
            // context.read<LoginCubit>(),
          ),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
