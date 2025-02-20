class HttpExceptionError {
  final String msg;
  final int statusCode;

  const HttpExceptionError({
    required this.msg,
    required this.statusCode,
  });

  @override
  String toString() {
    return msg;
  }
}
