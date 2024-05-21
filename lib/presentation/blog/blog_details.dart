import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/shared/utils/utils.dart';

import '../../global/global.dart';
import '../../model/blog/blog_model.dart';
import '../../resources/color_maneger.dart';
import '../../shared/component/k_text.dart';
import 'create_blog.dart';
import 'cubit/blog_cubit.dart';

class BlogDetails extends StatefulWidget {
  final BlogModel blog;
  const BlogDetails({
    super.key,
    required this.blog,
  });

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  late BlogModel blog = widget.blog;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {
        state.whenOrNull(
          deleteBlogLoading: () {
            context.loaderOverlay.show();
          },
          deleteBlogSuccess: () {
            context.loaderOverlay.hide();
            Navigator.of(context).pop();
          },
          deleteBlogFailed: () {
            context.loaderOverlay.hide();
            // Add your logic here
          },

          // Add your logic here
        );
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: kText(
              text: "",
              fontSize: 20.spMin,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              // more button to edit or delete vertically
              if (kUser != null && kUser!.uId == blog.author.uId)
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        // edit blog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateBlogScreen(
                              blog: blog,
                              selectedPlaces: [],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.edit),
                        title: kText(
                          text: "Edit",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        // delete blog
                        // Add your logic here
                        context.read<BlogCubit>().deleteBlog(blog: blog);
                      },
                      child: ListTile(
                        leading: const Icon(Icons.delete),
                        title: kText(
                          text: "Delete",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // cursoal image
                  CarouselSlider(
                    // check if images is not empty
                    items: blog.image != null && blog.image!.isNotEmpty
                        ? blog.image!
                            .map(
                              (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: e,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                            .toList()
                        : [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  responsive.sizedBoxH20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: blog.places!.length,
                        itemBuilder: (context, index) {
                          final place = blog.places![index];
                          return Container(
                            // padding bottom
                            margin: const EdgeInsets.only(bottom: 8).r,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: place.imageUrls != null &&
                                      place.imageUrls!.isNotEmpty
                                  ? ClipRRect(
                                      child: Image.network(
                                        place.imageUrls!.first,
                                      ),
                                    )
                                  : null,
                              title: kText(
                                text: place.name ?? "Name",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: kText(
                                text: place.address ?? "Address",
                              ),
                            ),
                          );
                        },
                      ),
                      responsive.sizedBoxH10,
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          // border from button only
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kText(
                              text: blog.title ?? "Title",
                              fontSize: 20.spMin,
                              maxLines: 4,
                              fontWeight: FontWeight.bold,
                            ),
                            // by author name
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Hero(
                                tag: blog.createdDate!,
                                // image or first letter of name
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage: blog.author.imageUrl != null
                                      ? CachedNetworkImageProvider(
                                          blog.author.imageUrl!,
                                        )
                                      : null,
                                  child: blog.author.imageUrl == null
                                      ? Text(
                                          blog.author.name![0],
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              title: kText(
                                text: blog.author.name ?? "Name",
                                fontSize: 12.spMin,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: kText(
                                text: Utils.timeAgo(blog.createdDate!),
                                fontSize: 10.spMin,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      responsive.sizedBoxH10,
                      buildSection(
                        title: 'My Experience',
                        value: blog.experience ?? "Experience",
                      ),
                      responsive.sizedBoxH10,
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildSection({
    required String title,
    required String value,
    String? value2,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4).r,
          child: kText(
            text: title,
            fontSize: 20.spMin,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (value2 != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
            child: Row(
              children: [
                Row(
                  children: [
                    kText(
                      text: "Latitude: ",
                      fontSize: 14.spMin,
                      color: AppColors.grey,
                    ),
                    kText(
                      text: double.parse(value).toStringAsFixed(2),
                      fontSize: 14.spMin,
                      maxLines: 2,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(width: 8.spMin),
                Row(
                  children: [
                    kText(
                      text: "Longitude: ",
                      fontSize: 14.spMin,
                      color: AppColors.grey,
                    ),
                    kText(
                      text: double.parse(value2).toStringAsFixed(2),
                      fontSize: 14.spMin,
                      maxLines: 2,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (value2 == null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).r,
            child: kText(
              text: value,
              fontSize: 14.spMin,
              maxLines: 10,
              color: AppColors.grey,
            ),
          ),
      ],
    );
  }
}
