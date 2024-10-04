import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class AttedantPage extends ConsumerStatefulWidget {
  const AttedantPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttedantPageState();
}

class _AttedantPageState extends ConsumerState<AttedantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        // mapController: ,
        mapController: MapController(),

        options: const MapOptions(
          initialZoom: 13,
          initialCenter: LatLng(-6.3802143, 106.7006292),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
        ],
      ),
    );
  }
}
