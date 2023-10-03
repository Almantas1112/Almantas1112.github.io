part of 'map_tapped_cubit.dart';

abstract class MapTappedState extends Equatable {
  const MapTappedState();

  @override
  List<Object?> get props => [];
}

class MapTappedInitial extends MapTappedState {}

class MapObjectFoundState extends MapTappedState {
  final MapModel info;

  MapObjectFoundState({
    required this.info,
  });

  @override
  List<Object?> get props => [
        info,
      ];
}

class MapObjectNotFoundState extends MapTappedState {}
