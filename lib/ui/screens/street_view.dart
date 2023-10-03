import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';

class StreetView extends StatefulWidget {
  final double latitude;
  final double longitude;

  const StreetView({
    Key? key,
    required this.longitude,
    required this.latitude,
  }) : super(key: key);

  @override
  State<StreetView> createState() => _StreetViewState();
}

class _StreetViewState extends State<StreetView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.39,
      height: 350,
      child: FlutterGoogleStreetView(
        initPos: LatLng(widget.latitude, widget.longitude),
        onStreetViewCreated: (StreetViewController controller) {
          controller.setPosition(
            position: LatLng(widget.latitude, widget.longitude),
          );
        },
      ),
    );
  }
}
