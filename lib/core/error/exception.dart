sealed class ApiException implements Exception {
  final String message;
  final Object? error;

  ApiException(this.message, this.error);
}

class ApiNoNetworkException extends ApiException {
  ApiNoNetworkException(super.message, super.error);
}

class ApiServerException extends ApiException {
  ApiServerException(super.message, super.error);
}

class ApiBadRequestException extends ApiException {
  ApiBadRequestException(super.message, super.error);
}
