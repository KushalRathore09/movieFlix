import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';
/// Interceptor for the app
class AppInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    return options;
  }

  @override
  Future onResponse(Response response) {
    final exception = _getErrorObject(response);
    if (exception != null) throw exception;
    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) async {
    // Check if error is of time out error
    if (error.type == DioErrorType.SEND_TIMEOUT ||
        error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.RECEIVE_TIMEOUT) {
      return ServerConnectionException(
          'Couldn\'t connect with server. Please try again.');
    }

    // Check if the error is regarding no internet connection.
    if (error.type == DioErrorType.DEFAULT && error.error is SocketException) {
      return NoInternetException();
    }

    // Check if server responded with non-success status code.
    // In this case, we will check if we got a specific error
    // from API to display to the user.
    if (error.type == DioErrorType.RESPONSE) {
      NetworkException networkException = _getErrorObject(error.response) ??
          NetworkException('Something went wrong, please try again!');
      return networkException;
    }
    return error;
  }

  /// Parses the response to get the error object if any
  /// from the API response based on status code.
  NetworkException _getErrorObject(Response response) {
    final responseData = response.data;
    if (responseData is Map) {
      final data = responseData['data'];
      if (data != null && data is Map && data.containsKey('errors')) {
        final errors = data['errors'];
        if (errors is String) {
          return NetworkException(
            errors,
          );
        } else if (errors is Map && errors.length > 0) {
          final errorsValue = errors.values.toList()[0];
          if (errorsValue is String && errorsValue?.isNotEmpty == true) {
            return NetworkException(
              errorsValue,
            );
          }
          if (errorsValue is List && errorsValue.isNotEmpty)
            return NetworkException(
              errorsValue[0],
            );
        }
        return NetworkException(
          'Something went wrong, please try again!',
        );
      } else {
        final errors = responseData['errors'];
        if (errors is String) {
          return NetworkException(
            errors,
          );
        } else if (errors is Map && errors.length > 0) {
          final errorsValue = errors.values.toList()[0];
          if (errorsValue is List && errorsValue.isNotEmpty)
            return NetworkException(
              errorsValue[0],
            );
        }
      }
    }
    return null;
  }
}
