part of 'gps_bloc.dart';

@immutable
class GpsState extends Equatable {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnable && isGpsPermissionGranted;

  const GpsState(
      {required this.isGpsEnable, required this.isGpsPermissionGranted});

  GpsState copywith({
    bool? isGpsEnable,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
          isGpsEnable: isGpsEnable ?? this.isGpsEnable,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  List<Object> get props => [isGpsEnable, isGpsPermissionGranted];
}
