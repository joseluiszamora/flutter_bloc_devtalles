import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  // inyeccion de dependencias, para que el bloc use funciones externas
  final Future<String> Function(int id) _fetchPokemonName;

  PokemonBloc({required Future<String> Function(int id) fetchPokemon})
      : _fetchPokemonName = fetchPokemon,
        super(const PokemonState()) {
    on<PokemonAdded>((event, emmit) {
      // crea una copia de la clase pokemons
      final newPokemons = Map<int, String>.from(state.pokemons);
      // si no existe el pokemon se lo crea
      newPokemons[event.id] = event.name;

      emmit(state.copyWith(
        pokemons: newPokemons,
      ));
    });
  }

  Future<String> fetchPokemonName(int id) async {
    // Si ya existe el pokemon, no lo trae de nuevo
    if (state.pokemons.containsKey(id)) {
      return state.pokemons[id]!;
    }

    try {
      final pokemonName = await _fetchPokemonName(id);
      add(PokemonAdded(id, pokemonName));
      return pokemonName;
    } catch (e) {
      throw Exception('Error al obtener el nombre del pokemon');
    }
  }
}
