import 'package:copains_de_route/position/position_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionCubit extends Cubit<PositionState> {
  PositionCubit() : super(PositionInitial());

  LatLng position = LatLng(48.864716, 2.349014);

  Future<void> initPosition() async {
    bool isServiceEnabled;
    LocationPermission permission;
    Position positionResult;
    emit(PositionLoading());
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!isServiceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('denied forever');
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('denied');
      }
    }
    positionResult = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = LatLng(positionResult.latitude, positionResult.longitude);
    emit(PositionSuccess(latlng: position));
  }

  void getPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    emit(
        PositionSuccess(latlng: LatLng(position.latitude, position.longitude)));
  }
}
