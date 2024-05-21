// import 'package:flutter/material.dart';
// import '/model/trip_destination/trip_destination_model.dart';

// import '../../model/trip_place/trip_place_model.dart';
// import '../../shared/utils/utils.dart';
// import 'visted_place_card.dart';

// class DayTimeLineVisitedPlace extends StatefulWidget {
//   final List<TripPlaceModel> places;

//   final TripDestinationModel tripDestination;
//   const DayTimeLineVisitedPlace({
//     super.key,
//     required this.places,
//     required this.tripDestination,
//   });

//   @override
//   State<DayTimeLineVisitedPlace> createState() =>
//       _DayTimeLineVisitedPlaceState();
// }

// class _DayTimeLineVisitedPlaceState extends State<DayTimeLineVisitedPlace> {
//   late List<TripPlaceModel> places;

//   late TripDestinationModel tripDestination;

//   @override
//   void initState() {
//     places = widget.places;

//     tripDestination = widget.tripDestination;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: places.length,
//       itemBuilder: (context, index) {
//         TripPlaceModel place = places[index];
//         //? on drag left delete place write this code

//         return Dismissible(
//           key: ValueKey(place.pId!),
//           direction: DismissDirection.endToStart,
//           background: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.red,
//             ),
//             child: const Align(
//               alignment: Alignment.centerRight,
//               child: Padding(
//                 padding: EdgeInsets.only(right: 20),
//                 child: Icon(
//                   Icons.delete,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           confirmDismiss: (direction) async {
//             return null;

//             // final response = await _showConfirmationDialog(
//             //   context,
//             //   visitedPlace,
//             // );
//             // return response;
//           },
//           child: VisitedPlaceCard(
//             key: ValueKey(place.pId),
//             place: place,
//           ),
//         );
//       },
//     );
//   }

//   Future<bool> _showConfirmationDialog(
//     BuildContext context,
//     TripPlaceModel place,
//   ) async {
//     bool isDeleted = false;
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Are you sure?'),
//         content: Text(
//           'Do you want to remove the ${place.name}?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               setState(() {
//                 isDeleted = false;
//               });
//             },
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await Utils.onRemoveVisitedPlaceFromTripDestination(
//                 destination: tripDestination,
//                 place: place,
//               );
//               Navigator.of(context).pop();
//               setState(() {
//                 isDeleted = true;
//               });
//             },
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );
//     return isDeleted;
//   }
// }
