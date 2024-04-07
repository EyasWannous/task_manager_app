import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._internetAuthentication, this._appBloc)
      : super(const LoginState());

  final InternetAuthentication _internetAuthentication;
  final AppBloc _appBloc;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  // Password ObscureText
  bool isvisible = false;
  void changeVisbilty() {
    final password = Password.dirty('${state.password.value} ');
    final password2 = Password.dirty(state.password.value);
    isvisible = !isvisible;
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
    emit(
      state.copyWith(
        password: password2,
        isValid: Formz.validate([state.email, password2]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      var token = await _internetAuthentication.login(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));

      _appBloc.add(AppTokenChecked(token ?? ''));
      // print('AppBloc $token');
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
      // } catch (_) {
      //   emit(state.copyWith(status: FormzSubmissionStatus.failure));
      // }
    }

    // Future<void> logInWithGoogle() async {
    //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    //   try {
    //     await _authenticationRepository.logInWithGoogle();
    //     emit(state.copyWith(status: FormzSubmissionStatus.success));
    //   } on LogInWithGoogleFailure catch (e) {
    //     emit(
    //       state.copyWith(
    //         errorMessage: e.message,
    //         status: FormzSubmissionStatus.failure,
    //       ),
    //     );
    //   } catch (_) {
    //     emit(state.copyWith(status: FormzSubmissionStatus.failure));
    //   }
    // }
  }
}
