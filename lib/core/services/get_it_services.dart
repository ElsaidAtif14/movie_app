import 'package:get_it/get_it.dart';
import 'package:movies/core/network/dio_client.dart';
import 'package:movies/core/services/api_service.dart';
import 'package:movies/core/services/database_service.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'package:movies/features/movies/repositories/movie_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<DatabaseService>(
    () => ApiServiceImpl(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      getIt<DatabaseService>(),
    ),
  );
}
