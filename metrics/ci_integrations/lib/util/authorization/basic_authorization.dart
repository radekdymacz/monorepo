part of authorization;

/// A class for the HTTP Basic authentication
/// (see [RFC-7617](https://tools.ietf.org/html/rfc7617)).
///
/// Example:
/// ```dart
/// final authorization = BasicAuthorization('username', 'password');
/// // prints {authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=}
/// print(authorization.toMap());
/// ```
class BasicAuthorization extends AuthorizationBase {
  BasicAuthorization(String username, String password)
      : super(
          HttpHeaders.authorizationHeader,
          'Basic ${encode(username, password)}',
        );

  /// Encodes [username] and [password] to a string that can be used within
  /// an HTTP request.
  ///
  /// If one of provided values is `null` then an empty string is used instead.
  static String encode(String username, String password) {
    final _username = username ?? '';
    final _password = password ?? '';
    return base64Encode(utf8.encode('$_username:$_password'));
  }
}
