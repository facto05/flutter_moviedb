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
import 'package:flutter_moviedb/core/data/repository/movie_repository_impl.dart'
    as _i182;
import 'package:flutter_moviedb/core/di/app_module.dart' as _i866;
import 'package:flutter_moviedb/core/domain/repository/movie_repository.dart'
    as _i948;
import 'package:flutter_moviedb/core/domain/usecase/movie/now_playing_movie_usecase.dart'
    as _i1003;
import 'package:flutter_moviedb/core/domain/usecase/movie/popular_movie_usecase.dart'
    as _i583;
import 'package:flutter_moviedb/core/domain/usecase/movie/top_rated_movie_usecase.dart'
    as _i491;
import 'package:flutter_moviedb/core/domain/usecase/movie/upcoming_movie_usecase.dart'
    as _i91;
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
    gh.singleton<_i948.MovieRepository>(
      () => _i182.MovieRepositoryImpl(gh<_i147.MovieService>()),
    );
    gh.singleton<_i1003.NowPlayingMovieUsecase>(
      () => _i1003.NowPlayingMovieUsecase(gh<_i948.MovieRepository>()),
    );
    gh.singleton<_i583.PopularMovieUsecase>(
      () => _i583.PopularMovieUsecase(gh<_i948.MovieRepository>()),
    );
    gh.singleton<_i491.TopRatedMovieUsecase>(
      () => _i491.TopRatedMovieUsecase(gh<_i948.MovieRepository>()),
    );
    gh.singleton<_i91.UpcomingMovieUsecase>(
      () => _i91.UpcomingMovieUsecase(gh<_i948.MovieRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i866.AppModule {}
