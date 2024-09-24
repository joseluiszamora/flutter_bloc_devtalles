import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_devtalles/config/config.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/domain.dart';

import '../../../domain/entities/todo.dart';

part 'guests_event.dart';
part 'guests_state.dart';

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc()
      : super(GuestsState(
          guests: List.generate(
              10,
              (index) => Todo(
                    id: const Uuid().v4(),
                    description: RandomGenerator.getRandomName(),
                    completedAt: index.isEven ? DateTime.now() : null,
                  )),
        )) {
    // on<SetInvitedFilterEvent>((event, emit) {
    //   emit(state.copyWith(filter: GuestFilter.invited));
    // });

    // on<SetNoInvitedFilterEvent>((event, emit) {
    //   emit(state.copyWith(filter: GuestFilter.notInvited));
    // });

    // on<SetAllFilterEvent>((event, emit) {
    //   emit(state.copyWith(filter: GuestFilter.all));
    // });

    on<SetCustomFilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.customFilter));
    });

    on<AddGest>(_addGuestHandler);

    on<ToggleGuest>(_toggleGuestHandler);
  }

  void changeFilter(GuestFilter filter) {
    add(SetCustomFilterEvent(filter));
  }

  void addGuest(String name) {
    add(AddGest(name));
  }

  void toggleGuest(String id) {
    add(ToggleGuest(id));
  }

  void _addGuestHandler(AddGest event, Emitter<GuestsState> emit) {
    final newGuest = Todo(
      id: const Uuid().v4(),
      description: event.name,
      completedAt: null,
    );
    emit(state.copyWith(guests: [...state.guests, newGuest]));
  }

  void _toggleGuestHandler(ToggleGuest event, Emitter<GuestsState> emit) {
    final newGuests = state.guests.map((e) {
      if (e.id == event.id) {
        return e.copyWith(
          completedAt: e.completedAt == null ? DateTime.now() : null,
        );
      }
      return e;
    }).toList();

    emit(state.copyWith(guests: newGuests));
  }
}
