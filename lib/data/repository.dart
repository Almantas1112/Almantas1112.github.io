import '../models/map_model.dart';
import 'network/api/auth.dart';
import 'network/api/data.dart';

class Repository {
  final DataApi _dataApi;
  final AuthApi _authApi;

  const Repository(
    this._authApi,
    this._dataApi,
  );

  //Get map properties
  Future<List<MapModel>> getMapData() => _dataApi.getMapsProperties();
}
