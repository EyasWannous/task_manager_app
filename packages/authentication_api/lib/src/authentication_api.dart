/// {@template authentication_api}
/// The interface and models for an API providing access to authentications.
/// {@endtemplate}
abstract class AuthenticationApi {
  /// {@macro authentication_api}
  const AuthenticationApi();

  /// Login API.
  Future<String?> login(String email, String password);

  /// Register API.
  Future<String?> register(String email, String password);

  /// Check If User Already have token
  Future<String?> checkLoggedIn();

  /// Logout and delete token
  Future<void> logOut();
}
