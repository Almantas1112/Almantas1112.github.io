import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gov_tech/data/network/constants/database_consts.dart';
import 'package:gov_tech/models/properties.dart';
import 'package:latlong2/latlong.dart';

class MapModel extends Equatable {
  final int id;
  final Properties properties;
  final String type;
  final List<LatLng> coords;

  const MapModel({
    required this.properties,
    required this.id,
    required this.coords,
    required this.type,
  });

  factory MapModel.fromMap(Map<String, dynamic> fromMap) {
    List<LatLng> latLngList = [];
    for (var i = 0;
        i <
            fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                    [DatabaseConsts.MAIN_COORDS_DOC_LIST]
                .length;
        i++) {
      if (fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                  [DatabaseConsts.MAIN_COORDS_DOC_LIST][i]
              .length !=
          2) {
        for (var z = 0;
            z <
                fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                        [DatabaseConsts.MAIN_COORDS_DOC_LIST][i]
                    .length;
            z++) {
          latLngList.add(LatLng(
              fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                  [DatabaseConsts.MAIN_COORDS_DOC_LIST][i][z][1],
              fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                  [DatabaseConsts.MAIN_COORDS_DOC_LIST][i][z][0]));
        }
      } else {
        latLngList.add(LatLng(
            fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                [DatabaseConsts.MAIN_COORDS_DOC_LIST][i][1],
            fromMap[DatabaseConsts.MAIN_COORDS_DOC]
                [DatabaseConsts.MAIN_COORDS_DOC_LIST][i][0]));
      }
    }
    return MapModel(
      properties: Properties.fromMap(fromMap[DatabaseConsts.PROPERTIES_DOC]),
      id: fromMap[DatabaseConsts.MAIN_ID],
      coords: latLngList,
      type: fromMap[DatabaseConsts.MAIN_COORDS_DOC][DatabaseConsts.MAIN_TYPE],
    );
  }

  @override
  List<Object> get props => [
        id,
        properties,
        type,
        coords,
      ];
}
