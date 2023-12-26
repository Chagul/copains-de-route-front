abstract class EditEventState {}

class EditEventInitialState extends EditEventState {
  EditEventInitialState();
}

class EditEventLoadingState extends EditEventState {}

class EditEventSuccessState extends EditEventState {}

class EditEventErrorState extends EditEventState {}
