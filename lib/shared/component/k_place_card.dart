import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novoy/shared/utils/utils.dart';

import '../../global/global.dart';
import '../../model/place/place_model.dart';
import '../../presentation/places details/places_details.dart';
import '../../resources/color_maneger.dart';
import '../../resources/constant_maneger.dart';
import '../../resources/responsive.dart';
import '../network/cache_helper.dart';
import 'k_text.dart';

class KPlaceCard extends StatefulWidget {
  final PlaceModel place;

  const KPlaceCard({
    super.key,
    required this.place,
  });

  @override
  State<KPlaceCard> createState() => _KPlaceCardState();
}

class _KPlaceCardState extends State<KPlaceCard> {
  late PlaceModel place = widget.place;

  bool isFav = false;

  @override
  void initState() {
    isFav = place.isFav!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlacesDetails(
              place: place,
              isAdd: false,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textFiled,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130.spMin,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: place.imageUrls!.isNotEmpty
                              ? place.imageUrls!.first
                              : "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: toggleFav,
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            responsive.sizedBoxH10,
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: kText(
                  text: place.name ?? "No Name",
                  fontSize: 12.spMin,
                  maxLines: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (place.address != null || place.address != "")
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: kText(
                    text: place.address ?? "No Address",
                    fontSize: 12,
                    color: AppColors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void toggleFav() async {
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
      await Utils.onToggleFav();
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
}
