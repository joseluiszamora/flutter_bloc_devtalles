import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_devtalles/main.dart';

import '../../blocs/blocs.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  int pokemonId = 1;

  @override
  Widget build(BuildContext context) {
    final pokemonbloc = context.read<PokemonBloc>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Pokemon ID: $pokemonId'),
        ),
        body: FutureBuilder(
            future: pokemonbloc.fetchPokemonName(pokemonId),
            initialData: pokemonbloc.state.pokemons[pokemonId] ?? "Loading",
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error al obtener el nombre del pokemon'),
                );
              }

              return Center(
                child: Text(snapshot.data!),
              );
            }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'btn-add',
              child: const Icon(Icons.plus_one),
              onPressed: () {
                pokemonId++;
                setState(() {
                  pokemonId = pokemonId;
                });
              },
            ),
            const SizedBox(height: 15),
            FloatingActionButton(
              heroTag: 'btn-minus',
              child: const Icon(Icons.exposure_minus_1),
              onPressed: () {
                if (pokemonId == 1) return;
                pokemonId--;
                setState(() {
                  pokemonId = pokemonId;
                });
              },
            ),
          ],
        ));
  }
}
