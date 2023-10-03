import 'package:equatable/equatable.dart';
import 'package:gov_tech/data/network/constants/database_consts.dart';

class Properties extends Equatable {
  final String code;
  final String streetName;
  final String jobDone;
  final int jobIndex;

  const Properties({
    required this.code,
    required this.streetName,
    required this.jobDone,
    required this.jobIndex,
  });

  factory Properties.fromMap(Map<String, dynamic> fromMap) =>
      Properties(
        code: fromMap[DatabaseConsts.PROPERTIES_CODE],
        streetName: fromMap[DatabaseConsts.PROPERTIES_NAME],
        jobDone: fromMap[DatabaseConsts.PROPERTIES_JOB_DONE],
        jobIndex: fromMap[DatabaseConsts.PROPERTIES_JOB_INDEX],
      );

  @override
  List<Object> get props =>
      [
        code,
        streetName,
        jobDone,
        jobIndex,
      ];
}
