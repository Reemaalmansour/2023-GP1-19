import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../resources/color_maneger.dart';
import '/model/trip/trip_model.dart';
import '/shared/component/k_text.dart';

class TripCard extends StatelessWidget {
  final TripModel tip;
  const TripCard({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.transparent,
      color: AppColors.lightPrimary,
      elevation: 2,
      shadowColor: AppColors.primary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            if (tip.destinations != null &&
                tip.destinations!.isNotEmpty &&
                tip.destinations![0].image != null &&
                tip.destinations![0].image!.isNotEmpty &&
                tip.destinations?[0].image?[0] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  tip.destinations![0].image![0],
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
                    tip.name ?? "",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),
                  kText(
                    text: tip.destinations?[0].description ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  kText(
                    text: tip.destinations?[0].createdAt != null
                        ? "${DateFormat.yMMMd().format(tip.destinations!.first.startDate!)} - ${DateFormat.yMMMd().format(tip.destinations!.last.leaveDate!)}"
                        : "",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    fontSize: 12,
                    color: AppColors.grey,
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
