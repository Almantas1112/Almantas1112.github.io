import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gov_tech/data/network/constants/database_consts.dart';
import 'package:gov_tech/models/map_model.dart';

class DataApi {
  DataApi();

  Future<List<MapModel>> getMapsProperties() async {
    String preData = await rootBundle.loadString('assets/maps/siauliai.json');
    Map<String, dynamic> jsonData = json.decode(preData);
    final List<dynamic> listOfData = jsonData[DatabaseConsts.MAIN_DOC];
    final List<MapModel> data = listOfData.map((fromMap) => MapModel.fromMap(fromMap)).toList();
    return data;
  }
}