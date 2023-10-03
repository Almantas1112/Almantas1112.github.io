import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gov_tech/models/map_model.dart';
import 'package:latlong2/latlong.dart';

part 'map_tapped_state.dart';

class MapTappedCubit extends Cubit<MapTappedState> {
  MapTappedCubit() : super(MapTappedInitial());

  void closeInfo() => emit(MapTappedInitial());

  void findDetails({
    required LatLng cords,
    required List<MapModel> listOfObjects,
  }) {
    MapModel? info;
    double minDistance = double.infinity;

    for (var details in listOfObjects) {
      for (var cordsInfo in details.coords) {
        double distance = _calculateDistance(cords, cordsInfo);
        if (distance < minDistance) {
          minDistance = distance;
          info = details;
        }
      }
    }

    if (info != null) {
      emit(MapObjectFoundState(
        info: info
      ));
    } else {
      emit(MapObjectNotFoundState());
    }
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371;
    final double lat1Radians = _degreesToRadians(point1.latitude);
    final double lon1Radians = _degreesToRadians(point1.longitude);
    final double lat2Radians = _degreesToRadians(point2.latitude);
    final double lon2Radians = _degreesToRadians(point2.longitude);

    final double deltaLat = lat2Radians - lat1Radians;
    final double deltaLon = lon2Radians - lon1Radians;

    final double a = (sin(deltaLat / 2) * sin(deltaLat / 2)) +
        (cos(lat1Radians) *
            cos(lat2Radians) *
            sin(deltaLon / 2) *
            sin(deltaLon / 2));

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final double distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
