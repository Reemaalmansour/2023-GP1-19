import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/model/trip_model.dart';

import '../../blocs/trip/trip_bloc.dart';

class EditTripName extends StatefulWidget {
  final TripModelN theTrip;
  const EditTripName({super.key, required this.theTrip});

  @override
  State<EditTripName> createState() => _EditTripNameState();
}

class _EditTripNameState extends State<EditTripName> {
  final TextEditingController _tripNameController = TextEditingController();

  @override
  void initState() {
    _tripNameController.text = widget.theTrip.name ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Trip Name'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    // textField for trip name
                    children: [
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _tripNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Trip Name',
                        ),
                      ),
                    ],
                  ),
                ),
                // save button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_tripNameController.text.isNotEmpty) {
                            BlocProvider.of<TripBloc>(context).add(
                              UpdateTrip(
                                updatedTrip: widget.theTrip.copyWith(
                                  name: _tripNameController.text,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
