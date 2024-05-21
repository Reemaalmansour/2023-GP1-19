import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import '/model/place/place_model.dart';
import '/resources/color_maneger.dart';
import '/resources/constant_maneger.dart';
import '/resources/responsive.dart';
import '/shared/component/k_text.dart';

import '../../global/global.dart';
import '../../model/category/category_model.dart';
import '../../model/google_places/google_places.dart';
import '../../shared/utils/utils.dart';
import '../places details/places_details.dart';
import 'widgets/category_places_card.dart';

class Category extends StatefulWidget {
  final String catName;
  final List<String> catTypes;
  const Category({
    super.key,
    required this.catTypes,
    required this.catName,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late String catName = widget.catName;
  late List<String> catTypes = widget.catTypes;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
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
    log("catTypes $catTypes");
    _loadData(categories: catTypes);
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

  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (ctx, update) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        responsive.sizedBoxH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            kText(text: "Filter", fontSize: 18.spMin),
                          ],
                        ),
                        responsive.sizedBoxH20,
                        kText(text: "Filter by category", fontSize: 15.spMin),
                        responsive.sizedBoxH10,
                        DropdownButtonFormField2(
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: Global.categories
                              .map(
                                (CategoryModel item) =>
                                    DropdownMenuItem<String>(
                                  value: item.cId,
                                  child: Text(
                                    item.name!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: selectedFilterCatId,
                          onChanged: (value) {
                            log("value type ${value.runtimeType}");
                            log("value $value");

                            update(() {
                              selectedFilterCatId = value;
                              for (var item in Global.categories) {
                                if (item.cId == value) {
                                  filterTypes = item.types!;
                                }
                              }
                            });
                            log("selectedFilterCatId $selectedFilterCatId");
                            log("filterTypes $filterTypes");
                          },
                          decoration: InputDecoration(
                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                            // the menu padding when button's width is not specified.

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),

                            // Add more decoration..
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        responsive.sizedBoxH20,
                        // search place by name
                        kText(text: "Search by City", fontSize: 15.spMin),
                        responsive.sizedBoxH10,
                        TextFormField(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: AppConstant.apiKey,
                              mode: Mode.fullscreen,
                              language: "ar",
                              strictbounds: false,
                              components: [Component(Component.country, "sa")],
                              types: [
                                '(cities)',
                              ],
                              onError: (err) {
                                print(err);
                              },
                            );
                            if (place != null) {
                              // log(place.toString());

                              final plist = GoogleMapsPlaces(
                                apiKey: AppConstant.apiKey,
                                apiHeaders:
                                    await const GoogleApiHeaders().getHeaders(),
                              );
                              String placeid = place.placeId ?? "0";
                              final detail =
                                  await plist.getDetailsByPlaceId(placeid);

                              final geometry = detail.result.geometry!;

                              setState(() {
                                selectedLocationLang = geometry.location.lat;
                                selectedLocationLang = geometry.location.lng;
                              });
                              update(() {
                                _searchController.text = place.description!;
                                selectedLocationLat = geometry.location.lat;
                                selectedLocationLang = geometry.location.lng;
                              });
                            }
                          },
                          readOnly: true,
                          controller: _searchController,
                          onChanged: (val) {
                            update(() {
                              _searchController.text = val;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  responsive.sizedBoxH10,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              log(selectedFilterCatId.toString());
                              // catName = selectedFilterCatId != null
                              //     ? categories
                              //         .firstWhere(
                              //           (element) =>
                              //               element.cId == selectedFilterCatId,
                              //         )
                              //         .name!
                              //     : catName;
                              if (selectedFilterCatId != null) {
                                final cat = Global.categories.firstWhere(
                                  (element) =>
                                      element.cId == selectedFilterCatId,
                                );
                                catName = cat.name!;
                              }
                              placeList.clear();
                              log("selectedLocationLang $selectedLocationLang selectedLocationLat $selectedLocationLat");
                              await _loadData(
                                categories: filterTypes.isNotEmpty
                                    ? filterTypes
                                    : catTypes,
                                selectedLang: selectedLocationLang,
                                selectedLat: selectedLocationLat,
                              );
                            },
                            child: kText(text: "Apply"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.transparent,
        title: kText(
          text: catName,
          fontSize: 18.spMin,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: showBottomSheet,
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0).r,
          child: Center(
            child: isLoading
                ? Center(
                    child: SpinKitFoldingCube(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                  )
                : placeList.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () async {
                          placeList.clear();
                          await _loadData(
                            categories: catTypes,
                          );
                        },
                        child: GridView(
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
                          children: List.generate(
                            placeList.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacesDetails(
                                      place: placeList[index],
                                      isAdd: false,
                                    ),
                                  ),
                                );
                              },
                              child: CategoryPlacesCard(
                                place: placeList[index],
                              ),
                            ),
                          ),
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
      ),
    );
  }

  Future<void> _loadData({
    required List<String> categories,
    double? selectedLat,
    double? selectedLang,
  }) async {
    setState(() {
      isLoading = true;
    });
    // if (categories.isNotEmpty) {
    //   categories.shuffle();
    // }
    try {
      var response;
      String typesQuery = "";
      if (categories.isNotEmpty) {
        typesQuery = categories.map((type) => 'type=$type').join('&');
      }
      // log("catTypes $typesQuery");
      // log("typesQuery $typesQuery");
      // log("lat lang $selectedLat lang $selectedLang");
      if (selectedLat != null && selectedLang != null) {
        response = await http.get(
          Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            'location=${selectedLat},${selectedLang}'
            '&radius=10000' // You can adjust the radius as needed
            '&$typesQuery'
            '&key=${AppConstant.apiKey}',
          ),
        );
      } else {
        response = await http.get(
          Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            'location=${Global.ksaDistrictsLatLng[math.Random().nextInt(Global.ksaDistrictsLatLng.length)]}'
            '&radius=10000' // You can adjust the radius as needed
            '&$typesQuery'
            '&key=${AppConstant.apiKey}',
          ),
        );
      }
      // log("data from response  $response");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        // log("data from json  $data");
        nextPage = data['next_page_token'];
        for (var item in data['results']) {
          final mapsPlace = GooglePlacesModel.fromJson(item);
          List<String> imageUrls = [];
          if (mapsPlace.photos != null) {
            for (var item in mapsPlace.photos!) {
              imageUrls.add(
                await Utils.getPhoto(
                  item.photoReference,
                ),
              );
            }
          }

          PlaceModel place = PlaceModel(
            pId: mapsPlace.placeId,
            name: mapsPlace.name,
            address: mapsPlace.vicinity ?? "",
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
            // priceLevel: data['results']['price_level'],
            // rating: mapsPlace.rating,
            // reference: data['results']['reference'],
            // userTotalRating: data['results']['user_ratings_total'],
            // openNow: data['results']['opening_hours']['open_now'],
          );

          placeList.add(place);
        }
      } else {
        log("error ${response.body}");
      }
    } catch (e) {
      log("error ${e.toString()}");
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchResultsPage(
    List<String> categories, {
    String? nextPageToken,
  }) async {
    List<PlaceModel> list = [];
    final typesQuery = categories.map((type) => 'type=$type').join('&');
    String apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=${24.7136},${46.6753}'
        '&radius=5000' // You can adjust the radius as needed
        '&$typesQuery'
        '&key=${AppConstant.apiKey}';
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
