class ApiException implements Exception {
  final String? message;
  final int statusCode;
  final String? errorText;

  ApiException({this.message, required this.statusCode, this.errorText});
}
