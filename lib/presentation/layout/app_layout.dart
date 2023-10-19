import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoy/presentation/home%20screen/cubit/cubit.dart';
import 'package:novoy/presentation/home%20screen/cubit/state.dart';

class AppLayout extends StatelessWidget {
  AppLayout({Key? key}) : super(key: key);

  // var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) => Scaffold(
        body:
            HomeCubit.get(context).screens[HomeCubit.get(context).currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            items: HomeCubit.get(context).bottomItems,
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (index) => HomeCubit.get(context).changeBottomNavBar(index),
          ),
        ),
      ),
    );
  }
}
