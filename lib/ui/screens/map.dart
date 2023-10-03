import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gov_tech/blocs/map_manager/map_manager_cubit.dart';
import 'package:gov_tech/blocs/map_tapped/map_tapped_cubit.dart';
import 'package:gov_tech/constants/app_colors.dart';
import 'package:gov_tech/data/network/constants/constants.dart';
import 'package:gov_tech/ui/screens/street_view.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapManagerCubit _mapManagerCubit;
  late MapTappedCubit _mapTappedCubit;

  bool foundInfo = false;
  bool _selectedAll = true;
  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;

  @override
  void initState() {
    super.initState();
    _mapManagerCubit = BlocProvider.of<MapManagerCubit>(context)..getMapData();
    _mapTappedCubit = BlocProvider.of<MapTappedCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapTappedCubit, MapTappedState>(
      listener: (context, state) {
        if (state is MapObjectFoundState) {
          setState(() {
            foundInfo = true;
          });
        } else if (state is MapObjectNotFoundState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Informacijos nerasta'),
            ),
          );
        }
      },
      child: BlocBuilder<MapManagerCubit, MapManagerState>(
        builder: (context, state) {
          if (state is MapLoadedState) {
            return Stack(
              children: [
                _buildMap(state: state),
                foundInfo ? _buildFoundData() : const SizedBox(),
              ],
            );
          } else if (state is MapLoadingState) {
            return _buildLoading();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildFoundData() {
    return BlocBuilder<MapTappedCubit, MapTappedState>(
      builder: (context, state) {
        if (state is MapObjectFoundState) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            foundInfo = false;
                          });
                          _mapTappedCubit.closeInfo();
                        },
                        icon: const Icon(Icons.close),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: _buildInfo(state),
                      ),
                      _buildStreetView(state),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildStreetView(MapObjectFoundState state) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: StreetView(
        longitude: state.info.coords[0].longitude,
        latitude: state.info.coords[0].latitude,
      ),
    );
  }

  Widget _buildInfo(MapObjectFoundState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(
          text: 'Vietovės informacija',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        _buildRowText(
          title: 'Gatvės pavadinimas:',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
          text: state.info.properties.streetName,
          style2: const TextStyle(
            fontSize: 17,
          ),
        ),
        _buildRowText(
          title: 'Darbas:',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
          text: state.info.properties.jobIndex == 0
              ? Constants.job_index_0
              : state.info.properties.jobIndex == 1
                  ? Constants.job_index_1
                  : Constants.job_index_2,
          style2: const TextStyle(
            fontSize: 17,
          ),
        ),
        _buildRowText(
          title: 'Atlikimas:',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
          text: state.info.properties.jobDone,
          style2: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget _buildRowText({
    required String title,
    required String text,
    TextStyle? style,
    TextStyle? style2,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: style,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: style2,
        ),
      ],
    );
  }

  Widget _buildText({
    required String text,
    TextStyle? style,
  }) {
    return Text(
      text,
      style: style,
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildMap({
    required MapLoadedState state,
  }) {
    return Column(
      children: [
        _buildFilterData(),
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: const LatLng(55.9230, 23.3377),
              zoom: 12,
              onTap: (TapPosition pos, LatLng cords) => _mapTappedCubit
                  .findDetails(cords: cords, listOfObjects: state.allData),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://ibasemaps-api.arcgis.com/arcgis/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}?apiKey=cdac3580aee012ff01a2c84971c6cedec909424e8a7d1b0e114fb38c9fc01037',
              ),
              PolygonLayer(
                polygons: state.polygonsList,
              ),
              PolylineLayer(
                polylines: state.polylineList,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterData() {
    return Column(
      children: [
        _buildText(
          text: 'Filtravimas',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              onPress: () {
                if (_selectedAll == false) {
                  _selectedAll = true;
                  _selected1 = false;
                  _selected2 = false;
                  _selected3 = false;
                  setState(() {});
                  _mapManagerCubit.getMapData();
                }
              },
              text: 'Visi pasirinkimai',
              color: _selectedAll ? AppColors.scaffoldColor : null,
              btnStyle: TextButton.styleFrom(
                backgroundColor:
                    _selectedAll ? Colors.grey : AppColors.scaffoldColor,
              ),
            ),
            _buildButton(
              onPress: () {
                if (_selected1 == false) {
                  _selectedAll = false;
                  _selected1 = true;
                  _selected2 = false;
                  _selected3 = false;
                  setState(() {});
                  _mapManagerCubit.getMapData(filterSelection: 1);
                }
              },
              text: 'Kelio remonto darbai',
              color: _selected1 ? AppColors.scaffoldColor : null,
              btnStyle: TextButton.styleFrom(
                backgroundColor:
                _selected1 ? Colors.grey : AppColors.scaffoldColor,
              ),
            ),
            _buildButton(
              onPress: () {
                if (_selected2 == false) {
                  _selectedAll = false;
                  _selected1 = false;
                  _selected2 = true;
                  _selected3 = false;
                  setState(() {});
                  _mapManagerCubit.getMapData(filterSelection: 2);
                }
              },
              text: 'Pakelių pjovimas',
              color: _selected2 ? AppColors.scaffoldColor : null,
              btnStyle: TextButton.styleFrom(
                backgroundColor:
                _selected2 ? Colors.grey : AppColors.scaffoldColor,
              ),
            ),
            _buildButton(
              onPress: () {
                if (_selected3 == false) {
                  _selectedAll = false;
                  _selected1 = false;
                  _selected2 = false;
                  _selected3 = true;
                  setState(() {});
                  _mapManagerCubit.getMapData(filterSelection: 3);
                }
              },
              text: 'Valymas',
              color: _selected3 ? AppColors.scaffoldColor : null,
              btnStyle: TextButton.styleFrom(
                backgroundColor:
                _selected3 ? Colors.grey : AppColors.scaffoldColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildButton({
    required Function()? onPress,
    required String text,
    required ButtonStyle btnStyle,
    required Color? color,
  }) {
    return TextButton(
      onPressed: onPress,
      style: btnStyle,
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
