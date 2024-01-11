import 'package:copains_de_route/cubit/position/position_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionCubit extends Cubit<PositionState> {
  PositionCubit() : super(PositionInitial());

  LatLng position = const LatLng(50.633333, 3.066667);

  Future<void> initPosition() async {
    emit(PositionLoading());
    bool isServiceEnabled;
    LocationPermission permission;
    Position positionResult;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!isServiceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      emit(PositionSuccess(latlng: position));
      return;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(PositionSuccess(latlng: position));
        return;
      }
    }
    positionResult = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = LatLng(positionResult.latitude, positionResult.longitude);
    emit(PositionSuccess(latlng: position));
  }
}
