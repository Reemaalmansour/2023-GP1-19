import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:novoy/presentation/blog/cubit/blog_cubit.dart';
import 'package:novoy/resources/strings_maneger.dart';

import '../../global/global.dart';
import '../../model/blog/blog_model.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/responsive.dart';
import '../login/login_screen.dart';
import '../login/register_screen.dart';
import 'widgets/blog_card.dart';

class MyBlogScreen extends StatefulWidget {
  const MyBlogScreen({super.key});

  @override
  State<MyBlogScreen> createState() => _MyBlogScreenState();
}

class _MyBlogScreenState extends State<MyBlogScreen> {
  List<BlogModel> blogs = [];
  @override
  void initState() {
    super.initState();
    if (context.read<BlogCubit>().blogs.isEmpty) {
      context.read<BlogCubit>().fetchMyBlogs();
    } else {
      blogs = context.read<BlogCubit>().myBlogs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {
        state.whenOrNull(
          fetchMyBlogLoading: () {
            context.loaderOverlay.show();
          },
          fetchMyBlogSuccess: (blog) {
            blogs = blog;
            context.loaderOverlay.hide();
          },
          fetchBlogFailed: () {
            context.loaderOverlay.hide();
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.myBlogs),
          ),
          body: kUser == null
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
              : blogs.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<BlogCubit>()
                            .fetchMyBlogs(forceRefresh: true);
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              AppAssets.noPlacesFound,
                              width: 200,
                              height: 300,
                            ),
                          ),
                          ListView(),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<BlogCubit>()
                            .fetchMyBlogs(forceRefresh: true);
                      },
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final blog = blogs[index];
                          return BlogCard(
                            key: ValueKey(blog.id),
                            blog: blog,
                          );
                        },
                        itemCount: blogs.length,
                      ),
                    ),
        );
      },
    );
  }
}
