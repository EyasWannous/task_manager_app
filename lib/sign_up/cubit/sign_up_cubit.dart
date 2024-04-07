import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:internet_authentication/internet_authentication.dart';
import 'package:task_manager_app/app/bloc/app_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._internetAuthentication, this._appBloc)
      : super(const SignUpState());

  final InternetAuthentication _internetAuthentication;
  final AppBloc _appBloc;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<bool> signUpFormSubmitted() async {
    if (!state.isValid) return false;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      var token = await _internetAuthentication.register(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));

      _appBloc.add(AppTokenChecked(token ?? ''));
      // _loginCubit.emailChanged(state.email.value);
      // _loginCubit.passwordChanged(state.password.value);
      // _loginCubit.logInWithCredentials();
      return (token != null && token.isNotEmpty);
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
      return false;
      // } catch (_) {
      //   emit(state.copyWith(status: FormzSubmissionStatus.failure));
      // }
    }
  }
}
