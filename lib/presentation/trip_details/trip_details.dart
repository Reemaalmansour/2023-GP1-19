import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/model/trip_model.dart';
import 'package:novoy/presentation/create_plan/add_destination.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/shared/component/k_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../blocs/trip/trip_bloc.dart';
import '../../global/global.dart';
import 'edit_trip_name.dart';
import 'share_tirp_with_users.dart';
import 'trip_time_line.dart';

class TripDetails extends StatefulWidget {
  final TripModelN tripModel;
  final bool isShared;
  TripDetails({
    super.key,
    required this.tripModel,
    required this.isShared,
  });

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late TripModelN theTrip = widget.tripModel;
  late bool isShared = widget.isShared;
  final ScreenshotController screenshotController = ScreenshotController();

  Future getPdf(Uint8List screenShot) async {
    // String tempPath = (await getTemporaryDirectory()).path;
    String fileName = "myFile";
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
            child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
          );
        },
      ),
    );
    String path = (await getTemporaryDirectory()).path;
    File pdfFile = await File('$path/$fileName.pdf').create();

    pdfFile.writeAsBytesSync(await pdf.save());
    await Share.shareFiles([pdfFile.path]);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => rebuild());
    super.initState();
  }

  void rebuild() {
    setState(() {
      theTrip = widget.tripModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    //List<TripLocation> locations = [];
    log("isShared ${isShared}");
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        List<TripDestination> destinations = [];
        if (isShared == false) {
          if (state is TripLoaded) {
            theTrip = state.trips
                .firstWhere((element) => element.tripId == theTrip.tripId);
            destinations = theTrip.destinations!;
          }
        } else {
          destinations = theTrip.destinations!;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(theTrip.name ?? ""),
            actions: [
              PopupMenuButton(
                onSelected: (value) async {
                  if (value == 1) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTripName(
                          theTrip: theTrip,
                        ),
                      ),
                    );
                  }
                  if (value == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDestinationScreen(
                          trip: theTrip,
                        ),
                      ),
                    );
                  } else if (value == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareTripWithUserScreen(
                          tripId: theTrip.tripId!,
                          usersIds: theTrip.users!,
                        ),
                      ),
                    );
                  } else if (value == 4) {
                    // share trip
                    await screenshotController.capture().then((value) async {
                      // log("value ${value}");
                      if (value == null) return;
                      await getPdf(value);
                    });
                  }
                  // your logic
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    if (kUser?.uId == theTrip.uId)
                      const PopupMenuItem(
                        child: Text("Edit Trip Name"),
                        value: 1,
                      ),
                    if (kUser?.uId == theTrip.uId)
                      const PopupMenuItem(
                        child: Text("Add Destination"),
                        value: 2,
                      ),
                    if (kUser?.uId == theTrip.uId)
                      const PopupMenuItem(
                        child: Text("Share Trip with User"),
                        value: 3,
                      ),
                    const PopupMenuItem(
                      child: Text("Share Trip"),
                      value: 4,
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Screenshot(
              controller: screenshotController,
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<TripBloc>()
                    ..add(
                      FetchAndUpdateTheTrip(
                        trip: theTrip,
                      ),
                    );
                },
                child: ListView.builder(
                  itemCount: destinations.length,
                  itemBuilder: (ctx, index) => buildDestination(
                    tripDestination: destinations[index],
                  ),
                ),
              ),
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: ElevatedButton(onPressed: () {}, child: Text("Save")),
          // ),
        );
      },
    );
  }

  void onDestinationDelete(TripDestination tripDestination) {
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
            onPressed: () {
              if (theTrip.destinations!.length > 1) {
                context.read<TripBloc>().add(
                      DeleteDestination(
                        trip: theTrip,
                        destination: tripDestination,
                      ),
                    );

                setState(() {
                  theTrip.destinations!.removeWhere(
                    (element) =>
                        element.destinationId == tripDestination.destinationId,
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

  Widget buildDestination({
    required TripDestination tripDestination,
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
                  if (kUser?.uId == theTrip.uId)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            var isEdit = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddDestinationScreen(
                                  trip: theTrip,
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
                        if (theTrip.destinations!.length > 1)
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
                tripId: theTrip.tripId!,
                tripDestination: tripDestination,
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
}
