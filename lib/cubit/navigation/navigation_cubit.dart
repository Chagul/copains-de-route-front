import 'package:copains_de_route/cubit/navigation/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(super.initialState);

  void navigateTo(int index) {
    emit(NavigationToState(index: index));
  }
}
