import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../../blocs/places/places_bloc.dart';
import '../../global/global.dart';
import '../../model/place_model.dart';
import '../../resources/color_maneger.dart';

class KPlaceCard extends StatelessWidget {
  final PlaceModel place;
  const KPlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (ctx, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.textFiled,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: place.imageUrls!.isNotEmpty
                          ? Image.network(
                              place.imageUrls!.first,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Image.asset(
                              place.image!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: kText(
                      text: place.name!,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: kText(
                      text: place.address!,
                      fontSize: 12,
                      color: ColorManager.grey,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  if (kUser != null) {
                    context.read<PlacesBloc>().add(
                          ToggleFav(
                            place: place,
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: kText(
                          text: "You must login first",
                          color: ColorManager.white,
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
                icon: Icon(
                  place.isFav! ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
