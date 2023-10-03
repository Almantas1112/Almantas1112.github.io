import 'package:dio/dio.dart';

class ApiException implements DioException {
  @override
  final String message;

  @override
  late final dynamic error;

  @override
  late final RequestOptions requestOptions;

  @override
  late final Response? response;

  @override
  late final StackTrace stackTrace;

  @override
  late final DioExceptionType type;

  ApiException(DioException dioError, this.message) {
    error = dioError.error;
    requestOptions = dioError.requestOptions;
    response = dioError.response;
    stackTrace = dioError.stackTrace;
    type = dioError.type;
  }

  @override
  String toString() {
    return message;
  }

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
        Response? response,
        DioExceptionType? type,
        Object? error,
        StackTrace? stackTrace,
        String? message}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class FetchDataException extends ApiException {
  FetchDataException(DioException dioError)
      : super(
    dioError,
    'Įvyko klaida bandant susisieti su serveriu',
  );

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
        Response? response,
        DioExceptionType? type,
        Object? error,
        StackTrace? stackTrace,
        String? message}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class BadRequestException extends ApiException {
  BadRequestException(DioException dioError)
      : super(
    dioError,
    'Klaidingas kreipimasis į serverį',
  );

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
        Response? response,
        DioExceptionType? type,
        Object? error,
        StackTrace? stackTrace,
        String? message}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class UnauthorisedException extends ApiException {
  UnauthorisedException(DioException dioError)
      : super(
    dioError,
    'Klaida. Vartotojas neautentifikuotas',
  );

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
        Response? response,
        DioExceptionType? type,
        Object? error,
        StackTrace? stackTrace,
        String? message}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ResourceNotFound extends ApiException {
  ResourceNotFound(DioException dioError)
      : super(
    dioError,
    'Rezultatų nėra',
  );

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
        Response? response,
        DioExceptionType? type,
        Object? error,
        StackTrace? stackTrace,
        String? message}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ConflictException extends ApiException {
  ConflictException(DioException dioError)
      : super(
    dioError,
    'Vartotojas su tokiu el. paštu jau priregistruotas',
  );

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
        Response? response,
        DioExceptionType? type,
        Object? error,
        StackTrace? stackTrace,
        String? message}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

