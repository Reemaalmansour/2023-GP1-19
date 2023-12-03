import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:novoy/model/place_model.dart';
import 'package:novoy/resources/assets_maneger.dart';
import 'package:novoy/resources/color_maneger.dart';

import '../../blocs/places/places_bloc.dart';
import '../../model/category_model.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/k_place_card.dart';
import '../../shared/component/k_text.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        List<CategoryModel> categories = HomeCubit.get(context).categories;
        var user = HomeCubit.get(context).userData;
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorOccurred) {
          return const Text(AppStrings.errorMsg);
        }
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
                    text: user?.name ?? "",
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
                  SizedBox(height: 150, child: buildCategories(categories)),
                  const SizedBox(height: 20),
                  buildDiscovery(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDiscovery() {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        List<PlaceModel> places = [];
        if (state is PlacesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlacesLoaded) {
          places = state.places;
        } else if (state is PlacesError) {
          return const Text(AppStrings.errorMsg);
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kText(
                  text: AppStrings.discovery,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                kText(
                  text: AppStrings.viewAll,
                  color: ColorManager.primary,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                places.length,
                (index) => KPlaceCard(
                  place: places[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildCategories(List<CategoryModel> categories) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kText(
              text: AppStrings.categories,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            kText(
              text: AppStrings.viewAll,
              color: ColorManager.primary,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ],
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              categories.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          categories[index].image!,
                          width: 36,
                          height: 36,
                          // scale: 0.5,
                          fit: BoxFit.scaleDown,
                        ),
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
      ],
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
                      language: "ar",
                      strictbounds: false,
                      components: [Component(Component.country, "sa")],
                      types: [],
                      onError: (err) {
                        print(err);
                      },
                    );
                    if (place != null) {
                      context.read<PlacesBloc>().add(
                            OnSearchAndAddToList(
                              place: place,
                              context: context,
                              isFav: false,
                            ),
                          );
                    }
                  },
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
      },
    );
  }
}
