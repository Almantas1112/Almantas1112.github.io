import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gov_tech/data/network/constants/constants.dart';
import 'package:gov_tech/models/map_model.dart';
import 'package:gov_tech/models/services.dart';
import 'package:random_x/random_x.dart';

import '../../data/repository.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final Repository repo;

  ServicesCubit({
    required this.repo,
  }) : super(ServicesInitial());

  Future<void> getServices() async {
    emit(ServicesLoadingState());
    try {
      List<MapModel> allStreetsData = await repo.getMapData();
      List<ServicesModel> mockedData =
          await _mockOrders(streetData: allStreetsData);
      mockedData.sort((a,b) => a.orderTime.compareTo(b.orderTime));
      emit(ServicesLoadedState(data: mockedData));
    } catch (e) {
      print('Error in ServicesCubit, getServices(). Error: $e');
      emit(const ServicesErrorState(errorMsg: 'Nepavyko gauti informacijos'));
    }
  }

  Future<List<ServicesModel>> _mockOrders({
    required List<MapModel> streetData,
  }) async {
    List<ServicesModel> list = [];
    String whoOrdered = 'Testinis žmogus';
    for (var i = 0; i < 100; i++) {
      DateTime orderTime = RndX.generateRandomDateBetween(
          start: DateTime(2022), end: DateTime(2023));
      DateTime? orderCompletedTime = _orderCompletedTime(orderTime);
      List<String> jobAndStreet = _getRandomOrderJobAndStreet(streetData);
      list.add(ServicesModel(
        orderCompletedTime: orderCompletedTime,
        orderJob: jobAndStreet[0],
        orderStreet: jobAndStreet[1],
        orderTime: orderTime,
        whoOrdered: whoOrdered,
      ));
    }
    return list;
  }

  List<String> _getRandomOrderJobAndStreet(List<MapModel> streetData) {
    List<String> jobAndStreet = [];
    final random = Random();
    MapModel element = streetData[random.nextInt(streetData.length)];
    if (element.properties.jobIndex == 0) {
      jobAndStreet.add(Constants.job_index_0);
    } else if (element.properties.jobIndex == 1) {
      jobAndStreet.add(Constants.job_index_1);
    } else {
      jobAndStreet.add(Constants.job_index_2);
    }
    jobAndStreet.add(element.properties.streetName);
    return jobAndStreet;
  }

  DateTime? _orderCompletedTime(DateTime orderTime) {
    Random randomBool = Random();
    bool isFinished = randomBool.nextBool();
    DateTime? orderCompletedTime;
    if (isFinished) {
      orderCompletedTime = orderTime.add(const Duration(days: 20));
    } else {
      orderCompletedTime = null;
    }
    return orderCompletedTime;
  }
}
