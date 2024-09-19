import 'package:flutter_bloc_devtalles/config/router/app_router.dart';
import 'package:get_it/get_it.dart';

import 'blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(UsernameCubit());
  getIt.registerSingleton(RouterSimpleCubit());
  getIt.registerSingleton(CounterCubit());
  getIt.registerSingleton(ThemeCubit());

  getIt.registerSingleton(GuestsBloc());
}
