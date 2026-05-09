import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class NetworkExceptionHandler {
  static Object handleApiException(dynamic error) {
    if (error is SocketException) {
      throw Failure("No internet connection");
    } else if (error is HttpException) {
      throw Failure("Service not currently available");
    } else if (error is TimeoutException) {
      throw Failure("Poor internet connection");
    } else if (error is Failure) {
      throw Failure(error.message);
    } else if (error is TypeError) {
      throw Failure("Sorry, an error has occurred");
    } else if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.badResponse:
          if (error.response!.data != null &&
              error.response!.data.toString().isNotEmpty) {
            log(
              'Begin ${error.response!.data.toString()} ${error.response!.data.toString().length}  ${error.response!.statusCode}',
            );
            if (error.response!.data is List) {
              log('Bad request ${error.response!.data.toString()}');
              throw Failure('Bad request');
            } else {
              final message = error.response!.data['error'];
              if (message.toString().contains('internal server error') ||
                  error.response!.statusCode == 500) {
                throw Failure('Some went wrong, internal server error.');
              } else {
                throw Failure(message);
              }
            }
          } else {
            final messageMap = error.error;
            log(messageMap.toString());
            log(error.response.toString());
            //final message = messageMap.toString();
            throw Failure(
              messageMap == null ? 'No response' : messageMap.toString(),
            );
          }
        case DioExceptionType.unknown:
          throw Failure("An unknown error occurred with API server");
        case DioExceptionType.badCertificate:
          throw Failure("SSL certificate error occurred");
        case DioExceptionType.connectionError:
          throw Failure("Poor internet connection");
        case DioExceptionType.connectionTimeout:
          throw Failure("Poor internet connection");
        default:
          throw Failure("Something went wrong");
      }
    } else {
      log('Something went wrong: $error');
      throw Failure("Something went wrong. Try again.");
    }
  }
}
