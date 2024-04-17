import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui; // imported as ui to prevent conflict between ui.Image and the Image widget
import "dart:math" as math;

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _initialPosition;
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  BitmapDescriptor? customIcon;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size(72, 72), // Adjust the size here to make it larger
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio = View.of(context).devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = math.min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  @override
  void initState() {
    getBitmapDescriptorFromSvgAsset(
      'assets/marker.svg',
      const Size(36, 36),
    ).then((BitmapDescriptor bitmapDescriptor) {
      customIcon = bitmapDescriptor;
    });
    _determinePosition().then((Position position) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        markers.add(Marker(
          markerId: const MarkerId('1'),
          position: _initialPosition!,
          icon: customIcon!,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 15,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: TextFormField(
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                hintText: 'Search',
                filled: true,
                fillColor: const Color(0xfff9f9f9),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xfff9f9f9),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: (_initialPosition == null)
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onTap: (LatLng latLng) {
                  FocusScope.of(context).unfocus();
                },
                onCameraMove: (position) {
                  setState(() {
                    _initialPosition = position.target;
                  });
                },
                onCameraIdle: () {
                  setState(() {
                    markers.clear();
                    markers.add(Marker(
                      markerId: const MarkerId('1'),
                      position: _initialPosition!,
                      icon: customIcon!,
                      infoWindow: InfoWindow(
                          title: 'Your Location ',
                          snippet: 'latitude ${_initialPosition!.latitude} and longitude ${_initialPosition!.longitude}'),
                    ));
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: _initialPosition!,
                  zoom: 12,
                ),
              ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.purple,
          onPressed: () {
            _determinePosition().then((Position position) async {
              setState(() {
                _initialPosition = LatLng(position.latitude, position.longitude);
                markers.clear();
                markers.add(Marker(
                  markerId: const MarkerId('1'),
                  position: _initialPosition!,
                  icon: customIcon!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                ));
                mapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _initialPosition!,
                    zoom: 12,
                  ),
                ));
              });
            });
          },
          child: const Icon(
            Icons.gps_fixed,
            color: Colors.white,
          ),
        ));
  }
}
