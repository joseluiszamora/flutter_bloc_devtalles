import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_devtalles/presentation/blocs/blocs.dart';

import '../../../config/config.dart';

class MultipleCubitScreen extends StatelessWidget {
  const MultipleCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = context.watch<CounterCubit>();
    final themeCubit = context.watch<ThemeCubit>();
    final usernameCubit = context.watch<UsernameCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Cubits'),
      ),
      body: Center(
          child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          IconButton(
            icon: themeCubit.state.isDarkmode
                ? const Icon(Icons.light_mode_outlined, size: 100)
                : const Icon(Icons.dark_mode_outlined, size: 100),
            onPressed: () {
              themeCubit.toggleTheme();
            },
          ),
          Center(
            child: Text(
              usernameCubit.state,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.add,
              size: 50,
            ),
            label: Text('${counterCubit.state}',
                style: const TextStyle(fontSize: 100)),
            onPressed: () {
              counterCubit.incrementBy(2);
            },
          ),
          const Spacer(flex: 2),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nombre aleatorio'),
        icon: const Icon(Icons.refresh_rounded),
        onPressed: () {
          usernameCubit.setUsername(
            RandomGenerator.getRandomName(),
          );
        },
      ),
    );
  }
}
