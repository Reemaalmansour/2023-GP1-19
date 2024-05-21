// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../global/global.dart';
import '../../model/category/category_model.dart';
import '../../model/google_places/google_places.dart';
import '../../shared/utils/utils.dart';
import '../add_place_to_trip/select_date/select_date.dart';
import '../add_place_to_trip/select_destination/select_destination.dart';
import '../category/widgets/category_places_card.dart';
import '/model/place/place_model.dart';
import '/model/trip/trip_model.dart';
import '/presentation/places%20details/places_details.dart';
import '/resources/color_maneger.dart';
import '/resources/constant_maneger.dart';
import '/shared/component/k_text.dart';

class RecommendedPlacesAI extends StatefulWidget {
  final TripModel trip;
  final List<String> catTypes;
  final int? avgRating;
  final int? threshold;
  final int? priceLevel;

  const RecommendedPlacesAI({
    Key? key,
    required this.catTypes,
    this.avgRating,
    this.threshold,
    this.priceLevel,
    required this.trip,
  }) : super(key: key);

  @override
  State<RecommendedPlacesAI> createState() => _RecommendedPlacesAIState();
}

class _RecommendedPlacesAIState extends State<RecommendedPlacesAI> {
  late TripModel trip;
  late List<String> catTypes;
  late int? avgRating;
  late int? threshold;
  late int? priceLevel;
  final ScrollController _scrollController = ScrollController();

  List<PlaceModel> placeList = [];
  List<CategoryModel> categories = [];
  List<String> catsName = [];
  String? selectedFilterCatId;
  String? nextPage;
  bool isLoading = false;
  String photoUrl = '';
  Uint8List? photoBytes;
  List<String> filterTypes = [];

  double? selectedLocationLat;
  double? selectedLocationLang;

  @override
  void initState() {
    super.initState();
    catTypes = widget.catTypes;
    avgRating = widget.avgRating;
    threshold = widget.threshold;
    priceLevel = widget.priceLevel;
    trip = widget.trip;

    log("catTypes $catTypes");
    // _loadData(
    //   categories: catTypes,
    //   avgRating: avgRating,
    //   threshold: threshold,
    //   priceLevel: priceLevel,
    // );
    fetchServerPlaces();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (nextPage != null) {
          _fetchResultsPage(
            catTypes,
            nextPageToken: nextPage,
          );
        }
      }
    });
  }

  Future<void> fetchServerPlaces() async {
    setState(() {
      isLoading = true;
    });
    placeList = await Utils.fetchServerRecommendedPlaces(
      tripName: trip.name,
      userID: kUser!.uId,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.transparent,
        title: kText(
          text: "Recommended Places",
          fontSize: 18.spMin,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0).r,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : placeList.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        placeList.clear();
                        await _loadData(
                          categories: catTypes,
                        );
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        // itemCount: placeList.length,
                        itemCount: placeList.length >= 6 ? 6 : placeList.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PlacesDetails(
                                        place: placeList[index],
                                        isAdd: false,
                                      ),
                                    ),
                                  );
                                },
                                child: CategoryPlacesCard(
                                  key: ValueKey(placeList[index].pId),
                                  place: placeList[index],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    // if Trip Has one Destination then go to pick date screen
                                    if (trip.destinations!.length == 1) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SelectData(
                                            place: placeList[index],
                                            trip: trip,
                                            tripDestination:
                                                trip.destinations![0],
                                          ),
                                        ),
                                      );
                                    } else {
                                      // if Trip Has more than one Destination then go to select destination screen
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TripDestinations(
                                            place: placeList[index],
                                            trip: trip,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 35.spMin,
                                    width: 35.spMin,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add_outlined,
                                      size: 20.spMin,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        placeList.clear();
                        await _loadData(
                          categories: catTypes,
                        );
                      },
                      child: Stack(
                        children: [
                          const Center(child: Text("No Data Found")),
                          ListView(),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  Future<void> _loadData({
    required List<String> categories,
    double? selectedLat,
    double? selectedLang,
    int? avgRating,
    int? threshold,
    int? priceLevel,
  }) async {
    setState(() {
      isLoading = true;
    });
    categories.shuffle();

    try {
      // if repeated categories, remove duplicates
      categories = categories.toSet().toList();
      // log("categories: $categories");
      // remove some categories
      // make this code 50% of the time
      if (math.Random().nextBool()) {
        categories.removeWhere((element) => element == "point_of_interest");
      }
      // categories.removeWhere((element) => element == "point_of_interest");
      categories.removeWhere((element) => element == "establishment");

      var response;
      // // String like "food,cafe,restaurant"
      // String typesQuery = "type=" + categories.join(',');

      String typesQuery = categories.map((type) => 'type=$type').join('&');
      log("typesQuery: $typesQuery");

      String baseUrl = AppConstant.nearbyPlacesBaseUrl;
      String apiKey = AppConstant.apiKey;
      String locationQuery;
      String minPrice = priceLevel != null && threshold != null
          ? ((priceLevel + threshold) - 1).toString()
          : '0';
      String maxPrice =
          priceLevel != null && threshold != null && priceLevel + threshold < 5
              ? (priceLevel + threshold).toString()
              : '4';

      if (selectedLat != null && selectedLang != null) {
        locationQuery = 'location=$selectedLat,$selectedLang';
        log("selected location: $locationQuery");
      } else {
        final randomLatLng = Global.ksaDistrictsLatLng[
            math.Random().nextInt(Global.ksaDistrictsLatLng.length)];

        log("randomLatLng: $randomLatLng");
        locationQuery = 'location=${randomLatLng}';
      }

      String fullUrl =
          '$baseUrl?$locationQuery&radius=10000&$typesQuery&key=$apiKey';
      response = await http.get(Uri.parse(fullUrl));

      log("data from response: $response");

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        log("data from json: $data");
        nextPage = data['next_page_token'];

        for (var item in data['results']) {
          final mapsPlace = GooglePlacesModel.fromJson(item);
          List<String> imageUrls = [];

          if (mapsPlace.photos != null) {
            for (var item in mapsPlace.photos!) {
              imageUrls.add(await Utils.getPhoto(item.photoReference));
            }
          }

          PlaceModel place = PlaceModel(
            pId: mapsPlace.placeId,
            name: mapsPlace.name,
            address: mapsPlace.vicinity ?? "",
            description: "",
            image: null,
            imageUrls: imageUrls,
            lat: mapsPlace.geometry?['location']['lat']?.toString() ?? "",
            lng: mapsPlace.geometry?['location']['lng']?.toString() ?? "",
            types: mapsPlace.types ?? [],
            isFav: false,
          );

          placeList.add(place);
        }
        // for (var i in placeList) {
        //   if (i.types.contains("restaurant") || i.types.contains("food")) {
        //     log("restaurant or food: $i");
        //   }
        // }
      } else {
        log("_loadData error: ${response.body}");
      }
    } catch (e) {
      log("_loadData error: ${e.toString()}");
    } finally {
      setState(() {
        placeList.shuffle();
        isLoading = false;
      });
    }
  }

  Future<void> _fetchResultsPage(
    List<String> categories, {
    String? nextPageToken,
    double? selectedLat,
    double? selectedLang,
  }) async {
    List<PlaceModel> list = [];
    final typesQuery = categories.map((type) => 'type=$type').join('&');
    String locationQuery;
    if (selectedLat != null && selectedLang != null) {
      locationQuery = 'location=$selectedLat,$selectedLang';
    } else {
      final randomLatLng = Global.ksaDistrictsLatLng[
          math.Random().nextInt(Global.ksaDistrictsLatLng.length)];

      log("randomLatLng: $randomLatLng");
      locationQuery = 'location=${randomLatLng}';
    }
    String apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?$locationQuery&radius=10000&$typesQuery&minprice=2&maxprice=5&key=${AppConstant.apiKey}';

    if (nextPageToken != null) {
      apiUrl += '&pagetoken=$nextPageToken';
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      nextPageToken = data['next_page_token'];

      if (data['status'] == 'OK') {
        for (var item in data['results']) {
          final mapsPlace = GooglePlacesModel.fromJson(item);
          List<String> imageUrls = [];

          if (mapsPlace.photos != null) {
            for (var item in mapsPlace.photos!) {
              imageUrls.add(await Utils.getPhoto(item.photoReference));
            }
          }

          PlaceModel place = PlaceModel(
            pId: mapsPlace.placeId,
            name: mapsPlace.name,
            address: "",
            description: "",
            image: null,
            imageUrls: imageUrls,
            lat: mapsPlace.geometry?['location']['lat'] != null
                ? mapsPlace.geometry!['location']['lat'].toString()
                : "",
            lng: mapsPlace.geometry?['location']['lng'] != null
                ? mapsPlace.geometry!['location']['lng'].toString()
                : "",
            types: mapsPlace.types ?? [],
            isFav: false,
          );

          list.add(place);

          if (nextPageToken == null) {
            setState(() {
              placeList = list;
            });
          } else {
            setState(() {
              placeList.addAll(list);
            });
          }
        }
      } else {
        print('Error: ${data['status']} - ${data['error_message']}');
      }
    } else {
      print('Failed to load places: ${response.statusCode}');
    }
  }
}
