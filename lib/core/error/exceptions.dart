
import 'package:flutter_moviedb/core/error/error_model.dart';

abstract class ServerException implements Exception {
  ErrorModel getErrorModel();
}

class LocalException implements Exception {}