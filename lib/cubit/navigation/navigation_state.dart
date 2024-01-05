abstract class NavigationState {}

class NavigationInitialState extends NavigationState {}

class NavigationToState extends NavigationState {
  final int index;

  NavigationToState({required this.index});
}
