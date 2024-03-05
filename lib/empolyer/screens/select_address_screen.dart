import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({Key? key}) : super(key: key);

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  late LatLng _initialPosition;
  late GoogleMapController _controller;
  location.Location _location = location.Location();
  late location.LocationData locationData;

  LatLng? _newPosition;

  void _onMapCreated(GoogleMapController _c) async {
    _controller = _c;
    _location.onLocationChanged.listen((l) {});
    locationData = await _location.getLocation();
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 15),
      ),
    );
  }

  void _loadLocationData() async {
    locationData = await _location.getLocation();
  }

  // @override
  // void didChangeDependencies() async {
  //   locationData = await _location.getLocation();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PositionedDirectional(
              top: 0,
              bottom: 0,
              end: 0,
              start: 0,
              child: GoogleMap(
                onCameraMove: (newPosition) async {
                  _newPosition = newPosition.target;
                  log('Lat -> ${_newPosition!.latitude} - Lng -> ${_newPosition!.longitude}');
                },
                onCameraIdle: () {
                  // log('Lat -> ${_newPosition!.latitude} - Lng -> ${_newPosition!.longitude}');
                },
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                mapToolbarEnabled: true,
                // onTap: (latLong) {
                //   log('Selected Location -> Lat:${latLong.latitude} - Lng:${latLong.longitude}');
                // },
                myLocationEnabled: true,
                // trafficEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0),
                ),
              ),
            ),
            PositionedDirectional(
              // top: 0,
              // bottom: 0,
              // start: 0,
              // end: 0,
              child: Center(
                child: Icon(
                  Icons.location_pin,
                  size: 48,
                  color: Colors.red,
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 30,
              start: 36,
              end: 36,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 46),
                    padding: EdgeInsets.zero),
                onPressed: () async {
                  Navigator.of(context).pop(_newPosition);
                },
                child: Text(
                  "اضف",
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
