import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:novoy/presentation/blog/cubit/blog_cubit.dart';
import 'package:novoy/resources/color_maneger.dart';
import 'package:novoy/resources/strings_maneger.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../../global/global.dart';
import '../../model/blog/blog_model.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/responsive.dart';
import '../login/login_screen.dart';
import '../login/register_screen.dart';
import 'my_blogs.dart';
import 'widgets/blog_card.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<BlogModel> blogs = [];
  @override
  void initState() {
    super.initState();
    if (context.read<BlogCubit>().blogs.isEmpty) {
      context.read<BlogCubit>().fetchBlogs();
    } else {
      blogs = context.read<BlogCubit>().blogs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {
        state.whenOrNull(
          fetchBlogLoading: () {
            context.loaderOverlay.show();
          },
          fetchBlogSuccess: (blog) {
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
            elevation: 0,
            surfaceTintColor: AppColors.transparent,
            shadowColor: AppColors.transparent,
            title: const Text(AppStrings.blog),
            actions: [
              TextButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => const MyBlogScreen(),
                    ),
                  )
                      .then((value) {
                    setState(() {
                      blogs = context.read<BlogCubit>().blogs;
                    });
                  });
                },
                child: kText(text: "My Blogs"),
              ),
            ],
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
                        context.read<BlogCubit>().fetchBlogs();
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
                        context.read<BlogCubit>().fetchBlogs();
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
