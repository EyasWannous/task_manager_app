import 'package:authentication_api/authentication_api.dart';

/// {@template internet_authentication}
/// Provide the logic of dealing with RESTFull Api of Authentications.
/// {@endtemplate}
class InternetAuthentication {
  /// {@macro internet_authentication}
  const InternetAuthentication({
    required AuthenticationApi authenticationApi,
  }) : _authenticationApi = authenticationApi;

  final AuthenticationApi _authenticationApi;

  /// Provides a [Future] that return token if the
  /// [email] and [password] is are correct and match in server.
  ///
  /// return `null` if they are not.
  Future<String?> login({required String email, required String password}) =>
      _authenticationApi.login(email, password);

  /// Provides a [Future] that return token after
  /// registeration of this [email] and [password].
  ///
  /// return `null` if they error happened.
  Future<String?> register({required String email, required String password}) =>
      _authenticationApi.register(email, password);

  /// Provides a [Future] that return token
  /// if the User has token Already
  /// return `null` if not.
  Future<String?> checkLoggedIn() => _authenticationApi.checkLoggedIn();

  /// Provides a [Future] that delete saved token
  /// and logout from the app
  Future<void> logOut() => _authenticationApi.logOut();
}
