import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager_app/login/cubit/login_cubit.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: !context.read<LoginCubit>().isvisible,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
            suffix: IconButton(
              icon: context.read<LoginCubit>().isvisible
                  ? const Icon(FontAwesomeIcons.eye)
                  : const Icon(FontAwesomeIcons.eyeSlash),
              // ? const Icon(Icons.visibility)
              // : const Icon(Icons.visibility_off),
              onPressed: () => context.read<LoginCubit>().changeVisbilty(),
            ),
          ),
        );
      },
    );
  }
}
