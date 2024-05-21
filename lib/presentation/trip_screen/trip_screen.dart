import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../resources/responsive.dart';
import '../create_plan/create_plan.dart';
import '../login/register_screen.dart';
import '../trip_details/trip_details.dart';
import '/global/global.dart';
import '/model/trip/trip_model.dart';
import '/presentation/login/login_screen.dart';
import '/resources/color_maneger.dart';
import '/shared/component/app_card.dart';
import '/shared/utils/utils.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  bool isMyTrips = true;
  String title = "My Trips";
  bool isLoading = false;

  List<TripModel> trips = [];
  List<TripModel> sharedTrips = [];

  @override
  void initState() {
    super.initState();
    if (Global.kTrips.isNotEmpty) {
      trips = Global.kTrips;
    } else {
      fetchUserTrips();
    }

    if (Global.kSharedTrips.isNotEmpty) {
      sharedTrips = Global.kSharedTrips;
    } else {
      fetchSharedTrips();
    }
  }

  void fetchUserTrips() async {
    setState(() {
      isLoading = true;
      context.loaderOverlay.show();
    });
    await Utils.fetchMyTrips();
    if (context.mounted)
      setState(() {
        trips = Global.kTrips;
        isLoading = false;
        context.loaderOverlay.hide();
      });
  }

  void fetchSharedTrips() async {
    setState(() {
      isLoading = true;
      context.loaderOverlay.show();
    });
    await Utils.fetchSharedTrips();
    if (context.mounted)
      setState(() {
        sharedTrips = Global.kSharedTrips;
        isLoading = false;
        context.loaderOverlay.hide();
      });
  }

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    TripModel trip,
    int index,
  ) async {
    bool isDeleted = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Do you want to remove the trip?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isDeleted = false;
              });
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await Utils.onDeleteTrip(
                trip: trip,
              );
              Navigator.of(context).pop();
              setState(() {
                isDeleted = true;
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return isDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: kUser == null
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 70,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ),
                  ),
                  responsive.sizedBoxH30,
                  Center(
                    child: SizedBox(
                      height: 70,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: isMyTrips
                                          ? AppColors.splash
                                          : Colors.white,
                                      foregroundColor: isMyTrips
                                          ? AppColors.white
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isMyTrips = true;
                                        title = "My Trips";
                                        // context.read<TripBloc>().add(
                                        //       LoadTrips(),
                                        //     );
                                      });
                                    },
                                    child: const Text("My Trips"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: !isMyTrips
                                          ? AppColors.splash
                                          : Colors.white,
                                      foregroundColor: !isMyTrips
                                          ? AppColors.white
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isMyTrips = false;

                                        title = "Shared Trips";
                                      });
                                    },
                                    child: const Text("Shared Trips"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isMyTrips
                            ? Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    // BlocProvider.of<TripBloc>(context).add(
                                    //   LoadTrips(),
                                    // );
                                  },
                                  child: ListView.separated(
                                    itemCount: trips.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final trip = trips[index];

                                      return Dismissible(
                                        key: Key(trip.tripId!),
                                        background: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red,
                                          ),
                                          child: const Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        direction: DismissDirection.endToStart,
                                        confirmDismiss: (direction) async {
                                          // show dialog
                                          final response =
                                              await _showConfirmationDialog(
                                            context,
                                            trip,
                                            index,
                                          );
                                          setState(() {
                                            if (response == true) {
                                              trips.removeAt(index);
                                            }
                                          });
                                          return response;
                                        },
                                        child: InkWell(
                                          onTap: () async {
                                            final response =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TripDetails(
                                                  tripModel: trip,
                                                  isShared: false,
                                                ),
                                              ),
                                            );
                                            if (response == null) {
                                              // update the trips
                                              fetchUserTrips();
                                            }
                                          },
                                          child: TripCard(
                                            tip: trip,
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10,
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    // BlocProvider.of<TripBloc>(context).add(
                                    //   LoadSharedTrips(),
                                    // );
                                  },
                                  child: ListView.separated(
                                    itemCount: sharedTrips.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final trip = sharedTrips[index];

                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TripDetails(
                                                tripModel: trip,
                                                isShared: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: TripCard(
                                          tip: trip,
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  if (kUser != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const CreatePlan(),
                                  ),
                                );

                                if (result == true) {
                                  fetchUserTrips();
                                }
                              },
                              child: const Text("Create Plan"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  responsive.sizedBoxH20,
                ],
              ),
            ),
    );
  }
}
