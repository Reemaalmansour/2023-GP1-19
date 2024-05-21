import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novoy/presentation/blog/create_blog.dart';
import 'package:novoy/resources/color_maneger.dart';

import '/presentation/home%20screen/cubit/cubit.dart';
import '/presentation/home%20screen/cubit/state.dart';

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            if (HomeCubit.get(context).currentIndex != 4) {
              HomeCubit.get(context).changeBottomNavBar(context, 4);
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateBlogScreen(),
                ),
              );
            }
          },
          // blog icon
          child: Icon(
            HomeCubit.get(context).currentIndex != 4
                ? Icons.document_scanner_outlined
                : Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        // in center
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            height: 75,
            color: AppColors.primary,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomNavBar(
                  currentIndex: HomeCubit.get(context).currentIndex,
                  index: 0,
                  icon: Icons.explore,
                  title: 'Explore',
                  onTap: () {
                    HomeCubit.get(context).changeBottomNavBar(context, 0);
                  },
                ),
                _buildBottomNavBar(
                  currentIndex: HomeCubit.get(context).currentIndex,
                  index: 1,
                  icon: Icons.favorite,
                  title: 'Favorite',
                  onTap: () {
                    HomeCubit.get(context).changeBottomNavBar(context, 1);
                  },
                ),
                SizedBox(width: 50.spMin, height: 50.spMin),
                _buildBottomNavBar(
                  currentIndex: HomeCubit.get(context).currentIndex,
                  index: 2,
                  icon: Icons.note_alt_outlined,
                  title: 'Trips',
                  onTap: () {
                    HomeCubit.get(context).changeBottomNavBar(context, 2);
                  },
                ),
                _buildBottomNavBar(
                  currentIndex: HomeCubit.get(context).currentIndex,
                  index: 3,
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    HomeCubit.get(context).changeBottomNavBar(context, 3);
                  },
                ),
              ],
            ),
          ),

          // IconButton(
          //   onPressed: () {
          //     HomeCubit.get(context).changeBottomNavBar(context, 0);
          //   },
          //   icon: Icon(Icons.home),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar({
    required int currentIndex,
    required int index,
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: currentIndex == index ? AppColors.white : Colors.white54,
          ),
          Text(
            title,
            style: TextStyle(
              color: currentIndex == index ? AppColors.white : Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
