import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:novoy/presentation/profile/cubit/profile_cubit.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/strings_maneger.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
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
                  Text('Welcome, ${user?.name ?? ""}'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(FontAwesomeIcons.faceLaughBeam)
                ],
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageAssets.explore),
                      fit: BoxFit.cover)),
            ),
          );
        });
  }
}
