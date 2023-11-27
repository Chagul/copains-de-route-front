import 'package:copains_de_route/position/position_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class PositionCubit extends Cubit<PositionState> {
  PositionCubit() : super(PositionInitial());

  late Position position;

  Future<void> initPosition() async {
    bool isServiceEnabled;
    LocationPermission permission;

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
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    emit(PositionSuccess(position: position));
  }

  void getPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    emit(PositionSuccess(position: position));
  }
}
