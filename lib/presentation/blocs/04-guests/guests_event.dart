part of 'guests_bloc.dart';

sealed class GuestsEvent extends Equatable {
  const GuestsEvent();

  @override
  List<Object> get props => [];
}

final class SetAllFilterEvent extends GuestsEvent {}

final class SetInvitedFilterEvent extends GuestsEvent {}

final class SetNoInvitedFilterEvent extends GuestsEvent {}

final class SetCustomFilterEvent extends GuestsEvent {
  final GuestFilter customFilter;

  const SetCustomFilterEvent(this.customFilter);
}
