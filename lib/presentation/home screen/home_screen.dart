import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '/model/place/place_model.dart';
import '/resources/assets_maneger.dart';
import '/resources/color_maneger.dart';
import '/shared/network/cache_helper.dart';
import '/shared/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../global/global.dart';
import '../../model/category/category_model.dart';
import '../../resources/constant_maneger.dart';
import '../../resources/routes_maneger.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/k_place_card.dart';
import '../../shared/component/k_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String locationMessage = "";
  // List<PlaceModel> recommendedList = [];
  bool isLoading = false;
  String? nextPage;
  List<PlaceModel> discoveryPlaces = [];
  List<PlaceModel> recentPlaces = [];

  @override
  void initState() {
    super.initState();

    requestLocationPermission();
    recentPlaces = Global.recentPlaces;
    discoveryPlaces = Global.discoveryPlaces;

    for (var place in discoveryPlaces) {
      place.isFav = Global.favPlaces.any((element) => element.pId == place.pId);
    }
    if (discoveryPlaces.isEmpty) fetchDiscoveryPlaces();

    // fetchTrips and shared trips
    Utils.fetchMyTrips();
    Utils.fetchSharedTrips();
  }

  Future<void> fetchDiscoveryPlaces() async {
    setState(() {
      isLoading = true;
    });
    discoveryPlaces = await Utils.fetchPlaces();
    // check if user mark any place as fav
    for (var place in discoveryPlaces) {
      place.isFav = Global.favPlaces.any((element) => element.pId == place.pId);
    }
    Global.discoveryPlaces = discoveryPlaces;
    // save to cache
    await CacheHelper.saveDataToHive(
      key: AppConstant.discoveryPlaces,
      value: discoveryPlaces,
    );
    if (context.mounted)
      setState(() {
        isLoading = false;
      });
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      getLocation();
    } else {
      setState(() {
        locationMessage = "Location permission denied";
      });
    }
  }

  void getLocation() async {
    try {
      Global.userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        locationMessage =
            "Latitude: ${Global.userPosition?.latitude}\nLongitude: ${Global.userPosition?.longitude}";
      });
    } catch (e) {
      print(e);
      setState(() {
        locationMessage = "Error getting location";
      });
    }
    log(locationMessage, name: "Location");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            kText(
              text: AppStrings.welcome.toUpperCase(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(width: 10),
            Align(
              alignment: Alignment.bottomLeft,
              child: kText(
                text: kUser?.name ?? "",
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.waving_hand_outlined, size: 14),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSearchBar(),
              const SizedBox(height: 20),
              SizedBox(
                height: 150.spMin,
                child: buildCategories(Global.categories),
              ),
              // build recommended places here
              SizedBox(height: 20.spMin),
              buildDiscovery(),
              SizedBox(height: 20.spMin),
              buildRecentPlaces(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDiscovery() {
    return buildListOfPlaces(
      places: discoveryPlaces,
      title: AppStrings.discovery,
    );
  }

  Widget buildRecentPlaces() {
    return buildListOfPlaces(
      places: recentPlaces,
      title: "Recent Places",
    );
  }

  Column buildListOfPlaces({
    required List<PlaceModel> places,
    required String title,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kText(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        const SizedBox(height: 10),
        places.isEmpty
            ? Center(
                child: Image.asset(
                  AppAssets.noPlacesFound,
                  width: 200,
                  height: 300,
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return KPlaceCard(
                    key: ValueKey(places[index].pId),
                    place: places[index],
                  );
                },
              ),
      ],
    );
  }

  Column buildCategories(List<CategoryModel> categories) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kText(
          text: AppStrings.categories,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              categories.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.category,
                    arguments: [
                      categories[index].types,
                      categories[index].name,
                    ],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 70.spMin,
                        height: 70.spMin,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: categories[index].icon != null
                            ? FaIcon(categories[index].icon)
                            : Image.asset(
                                categories[index].image!,
                                width: 36,
                                height: 36,
                                // scale: 0.5,
                                fit: BoxFit.scaleDown,
                              ),
                      ),
                      const SizedBox(height: 10),
                      kText(text: categories[index].name!, fontSize: 14),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.textFiled,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Image.asset(AppAssets.searchIcon, width: 24, height: 24),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              onTap: () => Utils.searchForPlaceDetails(context: context),
              readOnly: true,
              decoration: const InputDecoration(
                hintText: AppStrings.searchHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
