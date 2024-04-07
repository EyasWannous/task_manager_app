// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_manager_app/login/cubit/login_cubit.dart';

// class GoogleLoginButton extends StatelessWidget {
//   const GoogleLoginButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       key: const Key('loginForm_googleLogin_raisedButton'),
//       label: const Text(
//         'SIGN IN WITH GOOGLE',
//         style: TextStyle(color: Colors.white),
//       ),
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//       ),
//       icon: const Icon(
//         FontAwesomeIcons.google,
//         color: Colors.white,
//       ),
//       onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
//     );
//   }
// }
