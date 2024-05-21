import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../global/global.dart';
import '../../../resources/color_maneger.dart';
import '../../../resources/constant_maneger.dart';
import '../../../shared/component/k_text.dart';
import '../../../shared/network/cache_helper.dart';
import '/model/place/place_model.dart';

class CategoryPlacesCard extends StatefulWidget {
  final PlaceModel place;
  const CategoryPlacesCard({super.key, required this.place});

  @override
  State<CategoryPlacesCard> createState() => _CategoryPlacesCardState();
}

class _CategoryPlacesCardState extends State<CategoryPlacesCard> {
  late PlaceModel place = widget.place;
  bool isFav = false;

  @override
  void initState() {
    isFav = place.isFav!;
    super.initState();
  }

  void toggleFav() {
    //check if user login
    if (kUser != null) {
      setState(() {
        isFav = !isFav;
      });
      // update this place in favPlaces
      if (isFav) {
        place.isFav = true;
        Global.favPlaces.add(place);
      } else {
        place.isFav = false;
        Global.favPlaces.remove(place);
      }
      // update this place in cache
      CacheHelper.saveDataToHive(
        key: AppConstant.favPlacesCache,
        value: Global.favPlaces,
      );
    } else {
      // show snackbar to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: kText(
            text: "You must login first",
            color: AppColors.white,
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    log(" place.imageUrls?.first ${place.imageUrls}");
    return GridTile(
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: place.imageUrls!.isNotEmpty
                    ? place.imageUrls!.first
                    : "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                fit: BoxFit.fill,
                width: double.infinity,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: toggleFav,
              icon: Icon(
                place.isFav! ? Icons.favorite : Icons.favorite_border,
                size: 20,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(place.name ?? ""),
      ),
    );
  }
}
