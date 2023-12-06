import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/blocs/trip/trip_bloc.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/presentation/login/login_screen.dart';
import 'package:novoy/resources/color_maneger.dart';
import 'package:novoy/shared/component/app_card.dart';

import '../../model/trip_model.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '../create_plan/create_plan.dart';
import '../login/register_screen.dart';
import '../trip_details/trip_details.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  bool isMyTrips = true;
  bool isLoading = false;
  String title = "My Trips";
  List<TripModelN> sharedTrips = [];
  @override
  void didChangeDependencies() {
    if (kUser != null) {
      BlocProvider.of<TripBloc>(context)
          .add(LoadTrips(tripsIds: kUser?.tripsIds ?? []));
    }

    super.didChangeDependencies();
  }

  Future<void> getShared() async {
    List<TripModelN> allTrips = [];
    try {
      await FirebaseFirestore.instance
          .collection('trips')
          .where('users', arrayContains: kUser!.uId!)
          .get()
          .then((value) async {
        for (var i in value.docs) {
          final trip = TripModelN.fromJson(i.data());
          log("${trip.destinationsIds!.length}");
          List<TripDestination> newDestinations =
              List.from(trip.destinations ?? []);
          for (var i in trip.destinationsIds!) {
            await FirebaseFirestore.instance
                .collection('destination')
                .doc(i)
                .get()
                .then((value) {
              if (value.exists) {
                final destination = TripDestination.fromJson(value.data()!);
                log("${destination.name}");
                newDestinations.add(destination);
              }
            });
            log("${newDestinations.length}");

            trip.destinations = newDestinations;
          }

          allTrips.add(trip);
        }
      });

      setState(() {
        sharedTrips = allTrips;
        isLoading = false;
      });
    } catch (e) {
      log(e.toString());
    }
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
          : BlocBuilder<TripBloc, TripState>(
              builder: (context, state) {
                List<TripModelN> trips = [];
                if (state is TripLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TripError) {
                  return const Center(child: Text(AppStrings.errorMsg));
                } else if (state is TripEmpty) {
                  return const Center(child: Text('No Trips'));
                } else if (state is TripLoaded) {
                  trips = state.trips;
                } else if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Padding(
                  padding: const EdgeInsets.all(15.0),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    backgroundColor: isMyTrips
                                        ? ColorManager.splash
                                        : Colors.white,
                                    foregroundColor: isMyTrips
                                        ? ColorManager.white
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isMyTrips = true;
                                      title = "My Trips";
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
                                        ? ColorManager.splash
                                        : Colors.white,
                                    foregroundColor: !isMyTrips
                                        ? ColorManager.white
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isMyTrips = false;
                                      if (sharedTrips.isEmpty) {
                                        isLoading = true;
                                        title = "Shared Trips";
                                        getShared();
                                      }
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
                              child: ListView.separated(
                                itemCount: trips.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final trip = trips[index];

                                  return Dismissible(
                                    key: Key(trip.uId!),
                                    background: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red,
                                      ),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) async {
                                      // show dialog
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
                                              },
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                context.read<TripBloc>().add(
                                                      DeleteTrip(
                                                        trip: trip,
                                                      ),
                                                    );
                                                setState(() {
                                                  trips.removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TripDetails(
                                              tripModel: trip,
                                              isShared: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: TripCard(
                                        tripModelN: trip,
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
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemCount: sharedTrips.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
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
                                      tripModelN: trip,
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
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: kUser == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreatePlan(),
                    ),
                  );
                },
                child: const Text("Create Plan"),
              ),
            ),
    );
  }
}
