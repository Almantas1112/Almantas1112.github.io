part of 'services_cubit.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object?> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoadingState extends ServicesState {}

class ServicesLoadedState extends ServicesState {
  List<ServicesModel> data;

  ServicesLoadedState({
    required this.data,
  });

  @override
  List<Object> get props => [
        data,
      ];
}

class ServicesErrorState extends ServicesState {
  final String errorMsg;

  const ServicesErrorState({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [
        errorMsg,
      ];
}
