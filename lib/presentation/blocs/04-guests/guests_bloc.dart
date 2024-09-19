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
  }

  void changeFilter(GuestFilter filter) {
    add(SetCustomFilterEvent(filter));
    // switch (filter) {
    //   case GuestFilter.all:
    //     add(SetAllFilterEvent());
    //   case GuestFilter.invited:
    //     add(SetInvitedFilterEvent());
    //   case GuestFilter.notInvited:
    //     add(SetNoInvitedFilterEvent());
    // }
  }
}
