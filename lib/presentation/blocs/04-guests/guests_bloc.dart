import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/domain.dart';

part 'guests_event.dart';
part 'guests_state.dart';

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc() : super(const GuestsState()) {
    on<SetInvitedFilterEvent>((event, emit) {
      emit(state.copyWith(filter: GuestFilter.invited));
    });

    on<SetNoInvitedFilterEvent>((event, emit) {
      emit(state.copyWith(filter: GuestFilter.notInvited));
    });

    on<SetAllFilterEvent>((event, emit) {
      emit(state.copyWith(filter: GuestFilter.all));
    });
  }

  void changeFilter(GuestFilter filter) {
    switch (filter) {
      case GuestFilter.all:
        add(SetAllFilterEvent());
      case GuestFilter.invited:
        add(SetInvitedFilterEvent());
      case GuestFilter.notInvited:
        add(SetNoInvitedFilterEvent());
    }
  }
}
