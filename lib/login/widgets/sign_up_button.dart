import 'package:flutter/material.dart';
import 'package:task_manager_app/sign_up/view/sign_up.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        'CREATE ACCOUNT',
        style: theme.textTheme.bodySmall!.copyWith(color: Colors.white),
      ),
    );
  }
}
