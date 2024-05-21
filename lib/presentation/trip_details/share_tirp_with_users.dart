import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/model/trip_member/trip_member_model.dart';

import '../../model/user/user_model.dart';
import '../../resources/constant_maneger.dart';

class ShareTripWithUserScreen extends StatefulWidget {
  final String tripId;
  final List<TripMemberModel> tripMembers;

  const ShareTripWithUserScreen({
    Key? key,
    required this.tripId,
    required this.tripMembers,
  }) : super(key: key);

  @override
  State<ShareTripWithUserScreen> createState() =>
      _ShareTripWithUserScreenState();
}

class _ShareTripWithUserScreenState extends State<ShareTripWithUserScreen> {
  late String tripId;
  bool isExist = false;
  late List<TripMemberModel> tripMembers;
  final TextEditingController searchForEmailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    tripId = widget.tripId;
    tripMembers = widget.tripMembers;
  }

  bool checkIfUserExist(String email) {
    return tripMembers.any((member) => member.email == email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Trip"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() {}),
              controller: searchForEmailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            if (searchForEmailController.text.isNotEmpty &&
                searchForEmailController.text.length > 4)
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(AppConstant.usersCollection)
                    .snapshots(),
                builder: (ctx, snapShot) {
                  if (snapShot.hasData) {
                    final data = snapShot.data as QuerySnapshot;
                    final usersData = data.docs;
                    List<UserModel> users = usersData
                        .map(
                          (doc) => UserModel.fromJson(
                            doc.data() as Map<String, dynamic>,
                          ),
                        )
                        .toList();

                    List<UserModel> searchList = users
                        .where(
                          (user) =>
                              user.email!.toLowerCase() ==
                              searchForEmailController.text.toLowerCase(),
                        )
                        .toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (ctx, index) {
                          final user = searchList[index];
                          final member = TripMemberModel(
                            name: user.name,
                            email: user.email,
                            phone: user.phone,
                            age: user.age,
                            gender: user.gender,
                            uId: user.uId,
                          );

                          return ListTile(
                            title: Text(user.name ?? ""),
                            subtitle: Text(user.email ?? ""),
                            trailing: IconButton(
                              onPressed: () async {
                                if (checkIfUserExist(user.email!)) {
                                  await removeMemberFromTrip(member);
                                } else {
                                  await addMemberToTrip(member);
                                }
                              },
                              icon: checkIfUserExist(user.email!)
                                  ? const Icon(Icons.delete, color: Colors.red)
                                  : const Icon(Icons.share),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> removeMemberFromTrip(TripMemberModel member) async {
    await FirebaseFirestore.instance
        .collection(AppConstant.tripsCollection)
        .doc(tripId)
        .update({
      "groupMembers": FieldValue.arrayRemove([member.toJson()]),
    });

    await FirebaseFirestore.instance
        .collection(AppConstant.usersCollection)
        .doc(member.uId)
        .update({
      "sharedTripsIds": FieldValue.arrayRemove([tripId]),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${member.name} removed from trip"),
      ),
    );

    setState(() {
      searchForEmailController.text = "";
      tripMembers.remove(member);
    });
  }

  Future<void> addMemberToTrip(TripMemberModel member) async {
    await FirebaseFirestore.instance
        .collection(AppConstant.tripsCollection)
        .doc(tripId)
        .update({
      "groupMembers": FieldValue.arrayUnion([member.toJson()]),
    });

    await FirebaseFirestore.instance
        .collection(AppConstant.usersCollection)
        .doc(member.uId)
        .update({
      "sharedTripsIds": FieldValue.arrayUnion([tripId]),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${member.name} added to trip"),
      ),
    );

    setState(() {
      searchForEmailController.text = "";
      tripMembers.add(member);
    });
  }
}
