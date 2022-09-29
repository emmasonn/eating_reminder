class ApiResult<T> {}

class Success<T> extends ApiResult<T> {
  T result;
  Success({
    required this.result,
  });
}

class Error extends ApiResult {
  String message;
  Error({
    required this.message,
  });
}
