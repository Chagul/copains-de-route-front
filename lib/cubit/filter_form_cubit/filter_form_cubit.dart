import 'package:copains_de_route/cubit/filter_form_cubit/filter_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterFormCubit extends Cubit<FilterFormState> {
  // Road Types
  bool checkBoxPathCyclePath = false;
  bool checkBoxPathGravel = false;
  bool checkBoxPathPavingStones = false;
  bool checkBoxPathDirt = false;
  bool checkBoxPathRoad = false;
  bool checkBoxPathOthers = false;

  // Bike Types
  bool checkBoxBikeAllTerrain = false;
  bool checkBoxBikeGravel = false;
  bool checkBoxBikeCity = false;
  bool checkBoxBikeBMX = false;

  //Visibilities
  bool checkBoxPrivate = false;
  bool checkBoxPublic = false;

  //Distances
  int distanceMin = 0;
  int distanceMax = 0;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  FilterFormCubit() : super(FilterFormInitialState());

  void changePathDirt(value) {
    checkBoxPathDirt = value;
    emit(FilterFormChangedState());
  }

  void changePathGravel(value) {
    checkBoxPathGravel = value;
    emit(FilterFormChangedState());
  }

  void changePathPavingStones(value) {
    checkBoxPathPavingStones = value;
    emit(FilterFormChangedState());
  }

  void changePathOthers(value) {
    checkBoxPathOthers = value;
    emit(FilterFormChangedState());
  }

  void changePathCyclePath(value) {
    checkBoxPathCyclePath = value;
    emit(FilterFormChangedState());
  }

  void changePathRoad(value) {
    checkBoxPathRoad = value;
    emit(FilterFormChangedState());
  }

  void changeBikeAllTerrain(value) {
    checkBoxBikeAllTerrain = value;
    emit(FilterFormChangedState());
  }

  void changeBikeCity(value) {
    checkBoxBikeCity = value;
    emit(FilterFormChangedState());
  }

  void changeBikeBmx(value) {
    checkBoxBikeBMX = value;
    emit(FilterFormChangedState());
  }

  void changeBikeGravel(value) {
    checkBoxBikeGravel = value;
    emit(FilterFormChangedState());
  }

  void changeVisibilityPrivate(value) {
    checkBoxPrivate = value;
    emit(FilterFormChangedState());
  }

  void changeVisibilityPublic(value) {
    checkBoxPublic = value;
    emit(FilterFormChangedState());
  }

  void changeDistanceMin(value) {
    try {
      distanceMin = int.parse(value);
      emit(FilterFormChangedState());
    } catch (e) {
      emit(FilterFormMinDistanceErrorState());
    }
  }

  void changeDistanceMax(value) {
    try {
      distanceMax = int.parse(value);
      emit(FilterFormChangedState());
    } catch (e) {
      emit(FilterFormMaxDistanceErrorState());
    }
  }

  bool isFormValid() {
    if (!(checkBoxPathCyclePath ||
        checkBoxPathGravel ||
        checkBoxPathPavingStones ||
        checkBoxPathDirt ||
        checkBoxPathRoad ||
        checkBoxPathOthers)) {
      return false;
    }
    if (!(checkBoxBikeAllTerrain ||
        checkBoxBikeGravel ||
        checkBoxBikeCity ||
        checkBoxBikeBMX)) {
      return false;
    }
    if (!(checkBoxPrivate || checkBoxPublic)) {
      return false;
    }
    if (distanceMin > distanceMax) {
      return false;
    }
    if (distanceMin <= 0 || distanceMax <= 0) {
      return false;
    }
    try {
      DateTime.parse(startDateController.text);
      DateTime.parse(endDateController.text);
    } catch (e) {
      return false;
    }

    return true;
  }

  getFilterDtos() {
    print(startDateController.text);
  }
}
