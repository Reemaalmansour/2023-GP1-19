import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '/global/global.dart';
import '/model/trip_place/trip_place_model.dart';
import '/resources/widget_to_map_icon.dart';
import '/shared/component/k_text.dart';

import '../../resources/color_maneger.dart';

class ViewOnMap extends StatefulWidget {
  final List<TripPlaceModel> places;
  const ViewOnMap({
    super.key,
    required this.places,
  });

  @override
  State<ViewOnMap> createState() => _ViewOnMapState();
}

class _ViewOnMapState extends State<ViewOnMap> {
  late List<TripPlaceModel> places;
  int currentMarkerIndex = 0;
  List<Marker> markers = [];
  List<String> uniqueDates = [];
  // map controller
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    places = widget.places;
    _createMarkers();

    checkDaysCount();
  }

  void checkDaysCount() {
    // get date as day month year
    final dates =
        places.map((e) => DateFormat.yMMMd().format(e.visitDate!)).toList();

    // remove duplicates
    uniqueDates = dates.toSet().toList();
  }

  Future<void> _createMarkers() async {
    // Group the trips by createdAt
    final groupedTrips = groupBy(
      places,
      (places) => DateFormat.yMMMd().format(places.visitDate!),
    );

    List<Marker> setOfMarkers = [];

    log('Grouped Trips: ${groupedTrips.length}');

    int groupIndex = 0;
    for (var group in groupedTrips.values) {
      for (var trip in group) {
        final markerId = MarkerId(trip.pId ?? '');
        final marker = Marker(
          markerId: markerId,
          position: LatLng(
            double.tryParse(trip.lat ?? '0') ?? 0,
            double.tryParse(trip.lng ?? '0') ?? 0,
          ),
          icon: await getCustomIcon(
            createdAt: trip.visitDate!,
            color: Global.uniqueColors[groupIndex],
            placeName: trip.name,
          ),
          onTap: () {
            _showBottomSheet(trip);
          },
        );
        setOfMarkers.add(marker);
      }
      groupIndex++;
    }
    setState(() {
      markers = setOfMarkers;
    });
  }

  Future<void> _showBottomSheet(TripPlaceModel? place) async {
    if (place == null) return;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (place.imageUrls?.isNotEmpty ?? false)
                  SizedBox(
                    height: 200.spMin,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: place.imageUrls?.first ?? '',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                // kText(
                //   text: place.name ?? '',
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold,
                // ),
                buildSection(
                  title: 'Name',
                  value: place.name ?? '',
                ),
                buildSection(
                  title: 'Address',
                  value: place.address ?? '',
                ),
                // created by
                buildSection(
                  title: 'Add By',
                  value: place.createdBy?.name ?? '',
                ),
                // visited date
                buildSection(
                  title: 'Visit Date',
                  value: DateFormat.yMMMd().format(place.visitDate!),
                ),
              ],
            ),
          ),
          // Add more information as needed
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkDaysCount();
    return Scaffold(
      appBar: AppBar(
        title: const Text("View on map"),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        }.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          mapController = controller;
          // set them to the map controller
          // Set black theme
          mapController.setMapStyle(Global.mapStyle);

          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(
                double.tryParse(places[currentMarkerIndex].lat ?? '0') ?? 0,
                double.tryParse(places[currentMarkerIndex].lng ?? '0') ?? 0,
              ),
              14,
            ),
          );
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.8859, 45.0792),
          zoom: 5,
        ),
        markers: Set<Marker>.from(markers),
      ),
    );
  }

  Future<BitmapDescriptor> getCustomIcon({
    required DateTime createdAt,
    required Color color,
    required String? placeName,
  }) async {
    return SizedBox(
      height: 200,
      width: 200,
      child: Column(
        children: [
          Icon(
            Icons.location_on,
            size: 50,
            color: color,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black,
            child: Column(
              children: [
                kText(
                  text: placeName ?? 'Unknown',
                  fontSize: 12.spMin,
                ),
                kText(
                  text: DateFormat.yMMMd().format(createdAt),
                  fontSize: 12.spMin,
                ),
              ],
            ),
          ),
        ],
      ),
    ).toBitmapDescriptor();
  }

  buildSection({
    required String title,
    required String value,
    String? value2,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.grey.withOpacity(0.2),
          padding: const EdgeInsets.all(4).r,
          child: kText(
            text: title,
            fontSize: 16.spMin,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (value2 != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
            child: Row(
              children: [
                Row(
                  children: [
                    kText(
                      text: "Latitude: ",
                      fontSize: 14.spMin,
                      color: AppColors.grey,
                    ),
                    kText(
                      text: double.parse(value).toStringAsFixed(2),
                      fontSize: 14.spMin,
                      maxLines: 2,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(width: 8.spMin),
                Row(
                  children: [
                    kText(
                      text: "Longitude: ",
                      fontSize: 14.spMin,
                      color: AppColors.grey,
                    ),
                    kText(
                      text: double.parse(value2).toStringAsFixed(2),
                      fontSize: 14.spMin,
                      maxLines: 2,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (value2 == null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
            child: kText(
              text: value,
              fontSize: 14.spMin,
              maxLines: 10,
              color: AppColors.grey,
            ),
          ),
      ],
    );
  }
}
