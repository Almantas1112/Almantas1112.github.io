import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gov_tech/models/map_model.dart';

import '../../data/repository.dart';

part 'map_manager_state.dart';

class MapManagerCubit extends Cubit<MapManagerState> {
  final Repository repo;

  MapManagerCubit({
    required this.repo,
  }) : super(MapManagerInitial());

  Future<void> getMapData({
    int? filterSelection,
  }) async {
    emit(MapLoadingState());

    try {
      List<MapModel> dataList = await repo.getMapData();
      List<Polyline> polylineList = [];
      List<Polygon> polygonsList = [];
      for (var item in dataList) {
        if (item.type == 'LineString') {
          if (filterSelection == 1) {
            if (item.properties.jobIndex == 0) {
              polylineList.add(
                Polyline(
                  points: item.coords,
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              );
            }
          } else if (filterSelection == 2) {
            if (item.properties.jobIndex == 1) {
              polylineList.add(
                Polyline(
                  points: item.coords,
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              );
            }
          } else if (filterSelection == 3) {
            if (item.properties.jobIndex == 2) {
              polylineList.add(
                Polyline(
                  points: item.coords,
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              );
            }
          } else {
            polylineList.add(
              Polyline(
                points: item.coords,
                color: Colors.white,
                strokeWidth: 5,
              ),
            );
          }
        } else {
          if (filterSelection == 1) {
            if (item.properties.jobIndex == 0) {
              polygonsList.add(
                Polygon(
                  points: item.coords,
                  color: Colors.yellow,
                  borderStrokeWidth: 5,
                  isFilled: true,
                ),
              );
            }
          } else if (filterSelection == 2) {
            if (item.properties.jobIndex == 1) {
              polygonsList.add(
                Polygon(
                  points: item.coords,
                  color: Colors.yellow,
                  borderStrokeWidth: 5,
                  isFilled: true,
                ),
              );
            }
          } else if (filterSelection == 3) {
            if (item.properties.jobIndex == 2) {
              polygonsList.add(
                Polygon(
                  points: item.coords,
                  color: Colors.yellow,
                  borderStrokeWidth: 5,
                  isFilled: true,
                ),
              );
            }
          } else {
            polygonsList.add(
              Polygon(
                points: item.coords,
                color: Colors.yellow,
                borderStrokeWidth: 5,
                isFilled: true,
              ),
            );
          }
        }
      }
      emit(MapLoadedState(
        allData: dataList,
        polygonsList: polygonsList,
        polylineList: polylineList,
      ));
    } catch (e) {
      print('Error in MapManagerCubit, getMapData(). Error: $e');
      emit(MapErrorState(errorMsg: e.toString()));
    }
  }
}
