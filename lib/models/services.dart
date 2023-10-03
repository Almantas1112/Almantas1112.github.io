import 'package:equatable/equatable.dart';

class ServicesModel extends Equatable {
  final DateTime orderTime;
  final DateTime? orderCompletedTime;
  final String orderJob;
  final String orderStreet;
  final String whoOrdered;

  const ServicesModel({
    required this.orderCompletedTime,
    required this.orderJob,
    required this.orderStreet,
    required this.orderTime,
    required this.whoOrdered,
  });

  @override
  List<Object?> get props => [
        orderTime,
        orderCompletedTime,
        orderJob,
        orderStreet,
        whoOrdered,
      ];
}
