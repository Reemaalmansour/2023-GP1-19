import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../global/global.dart';
import '../../model/user_model.dart';

class ShareTripWithUserScreen extends StatefulWidget {
  final String tripId;
  List<String> usersIds;
  ShareTripWithUserScreen({
    super.key,
    required this.tripId,
    required this.usersIds,
  });

  @override
  State<ShareTripWithUserScreen> createState() =>
      _ShareTripWithUserScreenState();
}

class _ShareTripWithUserScreenState extends State<ShareTripWithUserScreen> {
  late String tripId = widget.tripId;
  late List<String> usersIds = widget.usersIds;
  final TextEditingController searchForEmailController =
      TextEditingController();

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
              onChanged: (value) {
                setState(() {});
              },
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
                stream:
                    FirebaseFirestore.instance.collection("user").snapshots(),
                builder: (ctx, snapShot) {
                  if (snapShot.hasData) {
                    List<UserModel> users = [];
                    final data = snapShot.data as QuerySnapshot;
                    final usersData = data.docs;
                    for (var i in usersData) {
                      final user =
                          UserModel.fromJson(i.data() as Map<String, dynamic>);
                      if (user.uId != kUser!.uId! &&
                          !usersIds.contains(user.uId)) users.add(user);
                    }
                    List<UserModel> searchList = users
                        .where(
                          (element) =>
                              element.email!.toLowerCase() ==
                              searchForEmailController.text.toLowerCase(),
                        )
                        .toList();
                    log(searchList.length.toString());
                    return Expanded(
                      child: ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (ctx, index) {
                          final user = searchList[index];
                          return ListTile(
                            title: Text(user.name ?? ""),
                            subtitle: Text(user.email ?? ""),
                            trailing: IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("trips")
                                    .doc(tripId)
                                    .update({
                                  "users": FieldValue.arrayUnion([user.uId]),
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${user.name} added to trip",
                                    ),
                                  ),
                                );
                                setState(() {
                                  searchForEmailController.text = "";
                                  usersIds.add(user.uId!);
                                });
                              },
                              icon: const Icon(Icons.share),
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
}
