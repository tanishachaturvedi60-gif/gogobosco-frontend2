import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gogobosco/core/theme.dart';

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
                    color: AppTheme.bgLight,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryRed.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.map_rounded,
                              size: 64,
                              color: AppTheme.primaryRed,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Map Disabled (Dev Mode)",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Google Maps interface is currently offline",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
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
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withValues(alpha: 0.06),
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search institutions, centers...",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: AppTheme.textMuted),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
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
                color: AppTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    color: Colors.black.withValues(alpha: 0.08),
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryRed.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.school, color: AppTheme.primaryRed, size: 26),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don Bosco Institution",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: AppTheme.textDark,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Guwahati, Assam • 1.2 km away",
                          style: TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.bgLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🎯 FLOATING BUTTON
          Positioned(
            bottom: 110,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: AppTheme.primaryRed,
              foregroundColor: Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: showMap
                  ? () {
                      mapController?.animateCamera(
                        CameraUpdate.newLatLng(initialPosition),
                      );
                    }
                  : null, // disabled if map is off
              child: const Icon(Icons.my_location_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

