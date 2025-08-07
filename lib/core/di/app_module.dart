
import 'package:flutter_moviedb/core/data/datasource/dio/network_provider.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule{
  @Singleton()
  NetworkProviderDio get networkProviderDio => NetworkProviderDio();
}