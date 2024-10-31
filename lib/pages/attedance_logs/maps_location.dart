import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapsLocations extends ConsumerStatefulWidget {
  const MapsLocations({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapsLocationsState();
}

class _MapsLocationsState extends ConsumerState<MapsLocations> {
  @override
  Widget build(BuildContext context) {
    LatLng currentLocation = const LatLng(0.0, 0.0);
    String lat = ref.watch(latProvider);
    String long = ref.watch(longProvider);
    double resultLat = double.tryParse(lat) ?? 0.0;
    double resultLong = double.tryParse(long) ?? 0.0;

    currentLocation = LatLng(resultLat, resultLong);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height, // Memenuhi tinggi layar
        child: Column(
          children: [
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: currentLocation,
                  initialZoom: 10.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currentLocation,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bootomSubmit('Get Current Location', Container(), () async {
                  LatLng newLocation = await _getCurrentLocation(ref);
                  // Memperbarui lokasi saat ini di provider
                  ref.read(latProvider.notifier).state =
                      newLocation.latitude.toString();
                  ref.read(longProvider.notifier).state =
                      newLocation.longitude.toString();
                }),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back to attendance'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<LatLng> _getCurrentLocation(WidgetRef ref) async {
    // Meminta izin lokasi
    await _requestLocationPermission();

    LatLng? newLocation;

    try {
      // Mendapatkan lokasi saat ini
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      newLocation = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
    }

    return newLocation ?? const LatLng(0.0, 0.0);
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }
  }
}
