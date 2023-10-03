part of 'map_manager_cubit.dart';

abstract class MapManagerState extends Equatable {
  const MapManagerState();

  @override
  List<Object?> get props => [];
}

class MapManagerInitial extends MapManagerState {}

class MapLoadingState extends MapManagerState {}

class MapErrorState extends MapManagerState {
  final String errorMsg;

  const MapErrorState({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [
        errorMsg,
      ];
}

class MapLoadedState extends MapManagerState {
  final List<MapModel> allData;
  final List<Polyline> polylineList;
  final List<Polygon> polygonsList;

  const MapLoadedState({
    required this.polygonsList,
    required this.polylineList,
    required this.allData,
  });

  @override
  List<Object> get props => [
        allData,
        polylineList,
        polygonsList,
      ];
}
