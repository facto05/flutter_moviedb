import 'package:dio/dio.dart';
import 'package:flutter_moviedb/core/error/error_model.dart';
import 'package:flutter_moviedb/core/error/exceptions.dart';

class NetworkException extends DioException implements ServerException{
  static const defaultErrorMessage = "Something went wrong, please try again.";
  late ErrorModel errorModel;

  DioException exception;

  NetworkException({required super.requestOptions, required this.exception}) {
    if (exception.response != null) {
      try {
        errorModel = ErrorModel.fromJson(exception.response!.data);
        if (errorModel.responseMessage.isEmpty) {
          handleError();
        }
      } catch (e) {
        handleError();
      }
    } else {
      handleError();
    }
  }

  String getMessage() => exception.message ?? defaultErrorMessage;

  int getResponseCode() => exception.response?.statusCode ?? 500;

  DioException getException() => exception;

  String getAppErrorMessage() {
    return errorModel.responseMessage;
  }

  @override
  String toString() {
    return errorModel.responseMessage;
  }

  void handleError() {
    errorModel =
        ErrorModel(responseCode: "500", responseMessage: defaultErrorMessage);
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        errorModel = ErrorModel(
            responseCode: "500",
            responseMessage: "The connection has timed out, please try again.");
        break;
      case DioExceptionType.badResponse:
        switch (exception.response?.statusCode) {
          case 400:
            errorModel = ErrorModel(
                responseCode: "400", responseMessage: "invalid request");
            break;
          case 401:
            errorModel = ErrorModel(
                responseCode: "401", responseMessage: "Access denied");
            break;
          case 404:
            errorModel = ErrorModel(
                responseCode: "404",
                responseMessage:
                    "The requested information could not be found");
            break;
          case 409:
            errorModel = ErrorModel(
                responseCode: "409", responseMessage: "Conflict occurred");
            break;
          case 500:
          case 502:
            errorModel = ErrorModel(
                responseCode:
                    exception.response?.statusCode?.toString() ?? "500",
                responseMessage:
                    "Unknown error occurred, please try again later.");
            break;
          default:
            errorModel = ErrorModel(
                responseCode:
                    exception.response?.statusCode?.toString() ?? "500",
                responseMessage: defaultErrorMessage);
            break;
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        errorModel = ErrorModel(
            responseCode: "0",
            responseMessage:
                "No internet connection detected, please try again.");
        break;
    }
  }

  @override
  ErrorModel getErrorModel() {
    return errorModel;
  }
}