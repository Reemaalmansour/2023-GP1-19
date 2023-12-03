import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:novoy/model/place_model.dart';

import '../../blocs/places/places_bloc.dart';
import '../../global/global.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/k_place_card.dart';
import '../login/login_screen.dart';
import '../login/register_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (ctx, state) {
        List<PlaceModel> places = [];
        if (state is PlacesLoaded) {
          places = state.places.where((element) => element.isFav!).toList();
        }

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
                      state is PlacesLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: GridView.builder(
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
      },
    );
  }

  Widget buildSearchBar() {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: ColorManager.textFiled,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Image.asset(AppAssets.searchIcon, width: 24, height: 24),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: AppStrings.googleApiKey,
                      mode: Mode.fullscreen,
                      language: "en",
                      components: [Component(Component.country, "sa")],
                      types: [],
                      strictbounds: false,
                      onError: (err) {
                        log(err.status.toString());
                      },
                    );
                    if (place != null) {
                      context.read<PlacesBloc>().add(
                            OnSearchAndAddToList(
                              place: place,
                              context: context,
                              isFav: true,
                            ),
                          );
                    }
                  },
                  readOnly: true,
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
      },
    );
  }
}
