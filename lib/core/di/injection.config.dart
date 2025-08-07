// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_moviedb/core/data/datasource/dio/network_provider.dart'
    as _i969;
import 'package:flutter_moviedb/core/data/datasource/service/movie_service.dart'
    as _i147;
import 'package:flutter_moviedb/core/data/datasource/service/movie_service_impl.dart'
    as _i475;
import 'package:flutter_moviedb/core/di/app_module.dart' as _i866;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i969.NetworkProviderDio>(() => appModule.networkProviderDio);
    gh.singleton<_i147.MovieService>(
      () => _i475.MovieServiceImpl(
        networkProviderDio: gh<_i969.NetworkProviderDio>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i866.AppModule {}
