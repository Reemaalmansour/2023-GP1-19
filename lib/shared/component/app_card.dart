import 'package:flutter/material.dart';
import 'package:novoy/model/trip_model.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../../resources/color_maneger.dart';

class TripCard extends StatelessWidget {
  final TripModelN tripModelN;
  const TripCard({
    Key? key,
    required this.tripModelN,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("tripModelN ${tripModelN.destinations?.length}");
    return Card(
      color: ColorManager.lightPrimary,
      elevation: 5,
      shadowColor: ColorManager.primary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            if (tripModelN.destinations != null &&
                tripModelN.destinations!.isNotEmpty &&
                tripModelN.destinations![0].image != null &&
                tripModelN.destinations![0].image!.isNotEmpty &&
                tripModelN.destinations?[0].image?[0] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  tripModelN.destinations![0].image![0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tripModelN.name ?? "",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),
                  kText(
                    text: tripModelN.destinations?[0].description ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
