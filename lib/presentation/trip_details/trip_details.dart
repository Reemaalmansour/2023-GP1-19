import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../global/global.dart';
import '../../model/trip_place/trip_place_model.dart';
import '../../shared/utils/save_file.dart';
import '../onMap/google_maps.dart';
import '../recommended_places_ai/recommended_places_ai.dart';
import '/model/trip/trip_model.dart';
import '/model/trip_destination/trip_destination_model.dart';
import '/presentation/create_plan/add_destination.dart';
import '/resources/color_maneger.dart';
import '/resources/responsive.dart';
import '/shared/component/k_text.dart';
import '/shared/utils/utils.dart';
import 'edit_trip_name.dart';
import 'share_tirp_with_users.dart';
import 'todo_list.dart';
import 'trip_members/trip_members.dart';
import 'trip_time_line.dart';

class TripDetails extends StatefulWidget {
  final TripModel tripModel;
  final bool isShared;

  final TripPlaceModel? addPlace;

  TripDetails({
    super.key,
    required this.tripModel,
    required this.isShared,
    this.addPlace,
  });

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  GlobalKey _globalKey = GlobalKey();
  TripModel? theTrip;
  late bool isShared = widget.isShared;
  late TripPlaceModel? addPlace = widget.addPlace;

  final ScreenshotController screenshotController = ScreenshotController();
  bool fullWidth = true;
  List<GeoPoint> locations = [];
  List<TripPlaceModel> allVisitedPlaces = [];
  List<String> getTypes = [];
  Future getPdf(Uint8List screenShot, bool isDownload) async {
    // String tempPath = (await getTemporaryDirectory()).path;
    String fileName =
        "${theTrip!.name}${DateTime.now().microsecondsSinceEpoch.toString()}";
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
            child: pw.Center(
              child: pw.Image(
                pw.MemoryImage(screenShot),
                fit: pw.BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
    if (isDownload) {
      Directory appDocDir = await getApplicationDocumentsDirectory();

      // Create a File object to represent the file in the documents directory
      File pdfFile = await File('${appDocDir.path}/$fileName.pdf').create();

      // Write the content to the file
      await FileStorage.writeCounter(pdfFile.path, "$fileName.pdf")
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "File Saved Successfully",
            ),
          ),
        );
      });
    } else {
      String path = (await getTemporaryDirectory()).path;
      File pdfFile = await File('$path/$fileName.pdf').create();

      pdfFile.writeAsBytesSync(await pdf.save());
      await Share.shareFiles(
        [
          pdfFile.path,
        ],
      );
    }
  }

  @override
  void initState() {
    theTrip = widget.tripModel;
    locations = getAllTripsLocations();

    // after 3 seconds change the width of the container
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        fullWidth = false;
      });
    });
    super.initState();
    getAllVisitedPlaces();
  }

  void getAllVisitedPlaces() {
    for (var destination in theTrip!.destinations!) {
      for (var place in destination.visitedPlaces!) {
        allVisitedPlaces = [...allVisitedPlaces, place];
      }
    }
    getAllTypes();
  }

  void getAllTypes() {
    getTypes = [];
    for (var place in allVisitedPlaces) {
      if (place.types.isNotEmpty) {
        getTypes = [...getTypes, ...place.types];
      }
    }
  }

  int getAveragePriceLevel() {
    int total = 0;
    int count = 0;
    for (var place in allVisitedPlaces) {
      if (place.priceLevel != null) {
        total += int.parse(place.priceLevel!);
        count++;
      }
    }
    // handel divide by zero
    if (count == 0) {
      return 0;
    }
    return total ~/ count;
  }

  int getAverageRating() {
    int total = 0;
    int count = 0;
    for (var place in allVisitedPlaces) {
      if (place.rating != null) {
        total += place.rating!.toInt();
        count++;
      }
    }
    // handel divide by zero
    if (count == 0) {
      return 0;
    }
    return total ~/ count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              var response;
              if (value == 1) {
                response = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTripName(
                      theTrip: theTrip!,
                    ),
                  ),
                );
                if (response == true) {
                  await Utils.onUpdateTripDestination(trip: theTrip!);
                  setState(() {
                    theTrip = Global.kTrips.firstWhere(
                      (element) => element.tripId == theTrip!.tripId,
                    );
                  });
                }
              }
              if (value == 2) {
                response = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDestinationScreen(
                      trip: theTrip!,
                    ),
                  ),
                );
                if (response != null) {
                  // update the trip with new destination
                  setState(() {
                    theTrip = Global.kTrips.firstWhere(
                      (element) => element.tripId == theTrip!.tripId,
                    );
                  });
                }
              } else if (value == 3) {
                final response = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShareTripWithUserScreen(
                      tripId: theTrip!.tripId!,
                      tripMembers: theTrip!.groupMembers ?? [],
                    ),
                  ),
                );
                if (response == null) {
                  // update the trip
                  setState(() {
                    theTrip = Global.kTrips.firstWhere(
                      (element) => element.tripId == theTrip!.tripId,
                    );
                  });
                }
              } else if (value == 4) {
                // share trip
                await screenshotController.capture().then((value) async {
                  // log("value ${value}");
                  if (value == null) return;
                  await getPdf(value, false);
                });
              } else if (value == 5) {
                // share trip
                await screenshotController.capture().then((value) async {
                  // log("value ${value}");
                  if (value == null) return;
                  await getPdf(value, true);
                });
              }
              // your logic
            },
            itemBuilder: (BuildContext bc) {
              return [
                if (kUser?.uId == theTrip!.createdBy?.uId)
                  const PopupMenuItem(
                    child: Text("Edit Trip Name"),
                    value: 1,
                  ),
                if (kUser?.uId == theTrip!.createdBy?.uId)
                  const PopupMenuItem(
                    child: Text("Add Destination"),
                    value: 2,
                  ),
                if (kUser?.uId == theTrip!.createdBy?.uId)
                  const PopupMenuItem(
                    child: Text("Share Trip with User"),
                    value: 3,
                  ),
                const PopupMenuItem(
                  child: Text("Share Trip"),
                  value: 4,
                ),
                const PopupMenuItem(
                  child: Text("Download Trip as PDF"),
                  value: 5,
                ),
              ];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: GestureDetector(
            onTap: () async {
              final response = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoListScreen(
                    trip: theTrip!,
                  ),
                ),
              );
              if (response != null || response == null) {
                setState(() {
                  theTrip = Global.kTrips.firstWhere(
                    (element) => element.tripId == theTrip!.tripId,
                  );
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.list),
                  responsive.sizedBoxW10,
                  kText(
                    text: "Todo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: screenBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var isEdit = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewOnMap(
                places: allVisitedPlaces,
              ),
            ),
          );

          if (isEdit == true) {
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.map),
      ),
      // center floating button
    );

    // BlocBuilder<TripBloc, TripState>(
    //   builder: (context, state) {
    //     if (state is TripLoading) {
    //       context.loaderOverlay.show();
    //     }
    //     if (state is TripLoaded) {
    //       context.loaderOverlay.hide();
    //       theTrip = state.trips
    //           .firstWhere((element) => element.tripId == theTrip!.tripId);
    //     }
    //     return
    //   },
    // );
  }

  Widget screenBody() {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        theTrip!.destinations?[0].image?[0] ?? "",
                      ),
                    ),
                    responsive.sizedBoxH10,
                    kText(
                      text: theTrip!.name ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (theTrip!.groupMembers!.length != 0)
                      GestureDetector(
                        onTap: () async {
                          final response = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripMembers(
                                theTrip: theTrip!,
                                isShared: isShared,
                              ),
                            ),
                          );
                          if (response == null) {
                            // update the trip
                            setState(() {
                              theTrip = Global.kTrips.firstWhere(
                                (element) => element.tripId == theTrip!.tripId,
                              );
                            });
                          }
                        },
                        child: kText(
                          text: (theTrip!.groupMembers!.length + 1).toString() +
                              " Members",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    RefreshIndicator(
                      onRefresh: () async {
                        if (isShared) {
                        } else {
                          await Utils.fetchMyTrips();
                        }
                        setState(() {
                          theTrip = Global.kTrips.firstWhere(
                            (element) => element.tripId == theTrip!.tripId,
                          );
                        });
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: theTrip!.destinations!.length,
                        itemBuilder: (ctx, index) => buildDestination(
                          tripDestination: theTrip!.destinations![index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // recommended Places

        Positioned(
          bottom: 50,
          left: 0,
          child: GestureDetector(
            onTap: () {
              getAllVisitedPlaces();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RecommendedPlacesAI(
                    trip: theTrip!,
                    catTypes: getTypes,
                    priceLevel: allVisitedPlaces.isNotEmpty
                        ? getAveragePriceLevel()
                        : 0,
                    avgRating:
                        allVisitedPlaces.isNotEmpty ? getAverageRating() : 0,
                    threshold: 1,
                  ),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: fullWidth ? 200.spMin : 100.spMin,
              height: 40.spMin,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                // for right side only rounded
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                // shadow
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: fullWidth
                  ? Row(
                      children: [
                        kText(
                          text: "Recommended Places",
                          color: Colors.white,
                        ),
                        responsive.sizedBoxW10,
                        const Icon(
                          Icons.recommend,
                          color: Colors.white,
                        ),
                      ],
                    )
                  : const Icon(
                      // recommended places
                      Icons.recommend,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  List<GeoPoint> getAllTripsLocations() {
    List<GeoPoint> locations = [];
    for (var destination in theTrip!.destinations!) {
      for (var destination in destination.visitedPlaces!) {
        locations.add(
          GeoPoint(
            double.parse(destination.lat!),
            double.parse(destination.lng!),
          ),
        );
      }
    }
    return locations;
  }

  void onDestinationDelete(TripDestinationModel tripDestination) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Destination"),
        content: const Text(
          "Are you sure you want to delete this destination?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (theTrip!.destinations!.length > 1) {
                await Utils.onDeleteDestination(
                  trip: theTrip!,
                  destination: tripDestination,
                );
                // update the trip
                setState(() {
                  theTrip = theTrip!.copyWith(
                    destinations: theTrip!.destinations!
                      ..removeWhere(
                        (element) =>
                            element.destinationId ==
                            tripDestination.destinationId,
                      ),
                  );
                });
                Navigator.pop(context, true);
              } else {
                // show snackbar at least one destination should be there
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "At least one destination should be there",
                    ),
                  ),
                );
                Navigator.pop(context, true);
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  Column buildDestination({
    required TripDestinationModel tripDestination,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.flight_takeoff_outlined),
                  responsive.sizedBoxW10,
                  Expanded(
                    child: kText(
                      maxLines: 3,
                      text: tripDestination.name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  responsive.sizedBoxW10,
                  if (kUser?.uId == theTrip!.createdBy?.uId)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            var isEdit = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddDestinationScreen(
                                  trip: theTrip!,
                                  oldDestination: tripDestination,
                                ),
                              ),
                            );

                            if (isEdit == true) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.edit, color: Colors.grey),
                        ),
                        if (theTrip!.destinations!.length > 1)
                          IconButton(
                            onPressed: () async {
                              onDestinationDelete(tripDestination);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                      ],
                    ),
                ],
              ),
              TripTimeLine(
                key: ValueKey(tripDestination.destinationId),
                tripId: theTrip!.tripId!,
                tripDestination: tripDestination,
                addPlace: addPlace,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  void onUpdateVistedPlaceInSideDestination(
    TripDestinationModel tripDestination,
    TripDestinationModel updatedDestination,
  ) {
    // context.read<TripBloc>().add(
    //       UpdateVisitedPlaceInSideDestination(
    //         trip: theTrip,
    //         destination: tripDestination,
    //         updatedDestination: updatedDestination,
    //       ),
    //     );
  }
}
