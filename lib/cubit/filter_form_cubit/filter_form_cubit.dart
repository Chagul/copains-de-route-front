import 'package:copains_de_route/cubit/filter_form_cubit/filter_form_state.dart';
import 'package:copains_de_route/model/filter_evenement.dart';
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

  List<String> roadTypes = [];
  List<String> bikeTypes = [];
  List<String> visibility = [];

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
    if (value) {
      roadTypes.add("DIRT");
    } else {
      roadTypes.remove("DIRT");
    }
    checkBoxPathDirt = value;
    emit(FilterFormChangedState());
  }

  void changePathGravel(value) {
    if (value) {
      roadTypes.add("GRAVEL");
    } else {
      roadTypes.remove("GRAVEL");
    }
    checkBoxPathGravel = value;
    emit(FilterFormChangedState());
  }

  void changePathPavingStones(value) {
    if (value) {
      roadTypes.add("PAVING_STONE");
    } else {
      roadTypes.remove("PAVING_STONE");
    }
    checkBoxPathPavingStones = value;
    emit(FilterFormChangedState());
  }

  void changePathOthers(value) {
    if (value) {
      roadTypes.add("OTHERS");
    } else {
      roadTypes.remove("OTHERS");
    }
    checkBoxPathOthers = value;
    emit(FilterFormChangedState());
  }

  void changePathCyclePath(value) {
    if (value) {
      roadTypes.add("CYCLE_PATH");
    } else {
      roadTypes.remove("CYCLE_PATH");
    }
    checkBoxPathCyclePath = value;
    emit(FilterFormChangedState());
  }

  void changePathRoad(value) {
    if (value) {
      roadTypes.add("ROAD");
    } else {
      roadTypes.remove("ROAD");
    }
    checkBoxPathRoad = value;
    emit(FilterFormChangedState());
  }

  void changeBikeAllTerrain(value) {
    if (value) {
      bikeTypes.add("ALL_TERRAIN");
    } else {
      bikeTypes.remove("ALL_TERRAIN");
    }
    checkBoxBikeAllTerrain = value;
    emit(FilterFormChangedState());
  }

  void changeBikeCity(value) {
    if (value) {
      bikeTypes.add("CITY");
    } else {
      bikeTypes.remove("CITY");
    }
    checkBoxBikeCity = value;
    emit(FilterFormChangedState());
  }

  void changeBikeBmx(value) {
    if (value) {
      bikeTypes.add("BMX");
    } else {
      bikeTypes.remove("BMX");
    }
    checkBoxBikeBMX = value;
    emit(FilterFormChangedState());
  }

  void changeBikeGravel(value) {
    if (value) {
      bikeTypes.add("GRAVEL");
    } else {
      bikeTypes.remove("GRAVEL");
    }
    checkBoxBikeGravel = value;
    emit(FilterFormChangedState());
  }

  void changeVisibilityPrivate(value) {
    if (value) {
      visibility.add("PRIVATE");
    } else {
      visibility.remove("PRIVATE");
    }
    checkBoxPrivate = value;
    emit(FilterFormChangedState());
  }

  void changeVisibilityPublic(value) {
    if (value) {
      visibility.add("PUBLIC");
    } else {
      visibility.remove("PUBLIC");
    }
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
    return FilterEvenement(distanceMin, distanceMax, startDateController.text,
        endDateController.text, roadTypes, bikeTypes, visibility);
  }
}
