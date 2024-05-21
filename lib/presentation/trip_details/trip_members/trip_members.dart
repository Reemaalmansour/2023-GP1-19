import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/global.dart';
import '../../../resources/color_maneger.dart';
import '../../../resources/constant_maneger.dart';
import '../../../resources/responsive.dart';
import '../../../shared/component/k_text.dart';
import '/model/trip/trip_model.dart';
import '/model/trip_member/trip_member_model.dart';

class TripMembers extends StatefulWidget {
  final TripModel theTrip;
  final bool isShared;
  const TripMembers({
    super.key,
    required this.theTrip,
    this.isShared = false,
  });

  @override
  State<TripMembers> createState() => _TripMembersState();
}

class _TripMembersState extends State<TripMembers> {
  late bool isShared;

  final fb = FirebaseFirestore.instance;

  TripModel? theTrip;
  bool isLoading = false;

  @override
  void initState() {
    theTrip = widget.theTrip;
    isShared = widget.isShared;
    super.initState();
  }

  Future<void> removeMemberFromTrip({
    required TripMemberModel member,
  }) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection(AppConstant.tripsCollection)
          .doc(theTrip!.tripId)
          .update({
        "groupMembers": FieldValue.arrayRemove([member.toJson()]),
      });

      await FirebaseFirestore.instance
          .collection(AppConstant.usersCollection)
          .doc(member.uId)
          .update({
        "sharedTripsIds": FieldValue.arrayRemove([
          theTrip!.tripId,
        ]),
      });
      // remover tripMember form groupMembers from trip in kTrips
      final tripIndex =
          Global.kTrips.indexWhere((trip) => trip.tripId == theTrip!.tripId);
      if (tripIndex != -1) {
        Global.kTrips[tripIndex].groupMembers!
            .removeWhere((element) => element.uId == member.uId);
      }
      theTrip = Global.kTrips[tripIndex];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${member.name} removed from trip"),
        ),
      );
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
      if (theTrip!.groupMembers!.isEmpty) {
        Navigator.pop(context);
      }
    }
  }

  void confirmationOnDelete({
    required TripMemberModel member,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: const Text('Are you sure?'),
        content: const Text('Do you want to remove this member from the trip?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            // padding

            onPressed: () => removeMemberFromTrip(member: member),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Members'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
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
                kText(
                  text: (theTrip!.groupMembers!.length + 1).toString() +
                      " Members",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              // owner of the trip
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.gold,
                    width: 1.5,
                  ),
                  // shadow
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(.5),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: kText(
                      text: theTrip!.createdBy!.name![0].toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  title: kText(text: theTrip!.createdBy!.name ?? ''),
                  subtitle: kText(text: theTrip!.createdBy!.email ?? ''),
                  trailing: Icon(
                    Icons.star,
                    color: AppColors.primary,
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: theTrip!.groupMembers!.length,
                itemBuilder: (context, index) {
                  final member = theTrip!.groupMembers![index];
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: kText(
                          text: member.name![0].toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      title: kText(text: member.name ?? ''),
                      subtitle: kText(text: member.email ?? ''),
                      trailing: isShared
                          ? null
                          : GestureDetector(
                              onTap: () => confirmationOnDelete(
                                member: member,
                              ),
                              child: Icon(
                                Icons.delete,
                                color: AppColors.red,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
