abstract class CreateItineraryState {}

class CreateItineraryStateInitial extends CreateItineraryState {}

class CreateItinerarySuccess extends CreateItineraryState {}

class CreateItineraryFailed extends CreateItineraryState {
  final int error;
  CreateItineraryFailed({required this.error});
}

class CreateItineraryLoading extends CreateItineraryState {}

class CreateItineraryRouteValidated extends CreateItineraryState {}
