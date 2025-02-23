class AuthException implements Exception {
  static const Map<String, String> authErrors = {
    'EMAIL_EXISTS': 'E-mail já está em uso...',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente, tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado na base de dados',
    'INVALID_PASSWORD': 'E-mail ou senha inválidos',
    'USER_DISABLED': 'Usuario desabilitado, contate o suporte',
    'INVALID_LOGIN_CREDENTIALS': 'E-mail ou senha inválidos',
  };

  final String errorType;

  AuthException(this.errorType);

  @override
  String toString() {
    return authErrors[errorType] ?? 'Ocorreu um erro na autenticação';
  }
}