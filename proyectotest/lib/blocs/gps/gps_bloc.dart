import 'dart:async';
import 'dart:isolate';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyectotest/blocs/bloc.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;
  GpsBloc()
      : super(GpsState(isGpsEnable: false, isGpsPermissionGranted: false)) {
    on<GpsPermissionEvent>((event, emit) => emit(state.copywith(
        isGpsEnable: event.isGpsEnable,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));
    _init();
  }
  Future<void> _init() async {
    final isEnable = await _checkGPs();
    final isGranted = await _isPermissionGranted();
    final gpsInitStatus =
        await Future.wait([_checkGPs(), _isPermissionGranted()]);

    add(GpsPermissionEvent(
        isGpsEnable: isEnable,
        isGpsPermissionGranted: state.isGpsPermissionGranted));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGPs() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final IsEnable = (event.index == 1) ? true : false;
      print('Service Status $IsEnable');
      add(GpsPermissionEvent(
          isGpsEnable: IsEnable,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
    return isEnable;
  }

  Future<void> askGps() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsPermissionEvent(
            isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsPermissionEvent(
            isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: false));
        openAppSettings();
    }
  }

  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
