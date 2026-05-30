import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  /// 🔥 Toggle this (true = real map, false = mock UI)
  final bool showMap = false;

  final LatLng initialPosition = const LatLng(26.1445, 91.7362); // Guwahati

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId("bosco1"),
      position: LatLng(26.1445, 91.7362),
      infoWindow: InfoWindow(title: "Don Bosco School"),
    ),
    const Marker(
      markerId: MarkerId("bosco2"),
      position: LatLng(26.1500, 91.7500),
      infoWindow: InfoWindow(title: "Bosco College"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🗺️ MAP / MOCK
          Positioned.fill(
            child: showMap
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: initialPosition,
                      zoom: 13,
                    ),
                    markers: markers,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                  )
                : Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Text(
                        "Map Disabled (Dev Mode)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
          ),

          /// 🔍 SEARCH BAR
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search institutions...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          /// 📍 BOTTOM CARD
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withValues(alpha: 0.15),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.school, color: Colors.red),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Don Bosco Institution",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Tap to view details",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),

          /// 🎯 FLOATING BUTTON
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFFD32F2F),
              onPressed: showMap
                  ? () {
                      mapController?.animateCamera(
                        CameraUpdate.newLatLng(initialPosition),
                      );
                    }
                  : null, // disabled if map is off
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
