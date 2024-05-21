import 'package:flutter/material.dart';

import '../../global/global.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/k_place_card.dart';
import '../login/login_screen.dart';
import '../login/register_screen.dart';
import '/model/place/place_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _searchController = TextEditingController();
  List<PlaceModel> places = Global.favPlaces;
  List<PlaceModel> filterList = [];

  void onSearch(val) {
    List<PlaceModel> temp = [];

    temp = places.where((element) {
      String title = element.name!.toLowerCase();
      String searchValue = val.toLowerCase();
      return title.contains(searchValue);
    }).toList();

    setState(() {
      filterList = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favorite),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: kUser == null
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text("Register"),
                        ),
                      ),
                    ),
                    responsive.sizedBoxH30,
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSearchBar(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: filterList.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              PlaceModel currentPlace = filterList[index];
                              return KPlaceCard(
                                key: ValueKey(currentPlace.pId),
                                place: currentPlace,
                              );
                            },
                            itemCount: filterList.length,
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              PlaceModel currentPlace = places[index];
                              return KPlaceCard(
                                key: ValueKey(currentPlace.pId),
                                place: currentPlace,
                              );
                            },
                            itemCount: places.length,
                          ),
                  ),
                ],
              ),
      ),
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
              onChanged: onSearch,
              controller: _searchController,
              readOnly: false,
              decoration: const InputDecoration(
                hintText: AppStrings.searchHintInFav,
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
