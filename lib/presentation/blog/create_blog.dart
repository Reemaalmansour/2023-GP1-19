import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/blog/blog_model.dart';
import 'package:novoy/model/place/place_model.dart';
import 'package:novoy/presentation/blog/cubit/blog_cubit.dart';
import 'package:novoy/resources/responsive.dart';
import 'package:novoy/shared/component/k_text.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../shared/utils/utils.dart';

class CreateBlogScreen extends StatefulWidget {
  final List<PlaceModel>? selectedPlaces;
  final BlogModel? blog;

  const CreateBlogScreen({
    super.key,
    this.selectedPlaces,
    this.blog,
  });

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<PlaceModel> _selectedPlace = [];
  BlogModel? blog;
  bool _isEdit = false;

  List<File> _images = [];
  List<String> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _selectedPlace = widget.selectedPlaces ?? [];
    blog = widget.blog;
    if (blog != null) {
      _isEdit = true;
      _titleController.text = blog!.title ?? "";
      _contentController.text = blog!.experience ?? "";
      _selectedPlace = blog!.places ?? [];
      _selectedImages = blog!.image ?? [];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, BlogState>(
      listener: (context, state) {
        state.maybeWhen(
          createBlogLoading: () {
            context.loaderOverlay.show();
          },
          createBlogSuccess: () {
            context.loaderOverlay.hide();
            Navigator.of(context).pop();
          },
          createBlogFailed: () {
            context.loaderOverlay.hide();
            // show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to create blog"),
              ),
            );
          },
          updateBlogLoading: () {
            context.loaderOverlay.show();
          },
          updateBlogSuccess: () {
            context.loaderOverlay.hide();
            Navigator.of(context).pop();
          },
          updateBlogFailed: () {
            context.loaderOverlay.hide();
            // show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to update blog"),
              ),
            );
          },
          deleteBlogLoading: () => context.loaderOverlay.show(),
          deleteBlogSuccess: () {
            context.loaderOverlay.hide();
            Navigator.of(context).pop();
          },
          deleteBlogFailed: () {
            context.loaderOverlay.hide();
            // show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to delete blog"),
              ),
            );
          },
          orElse: () {
            context.loaderOverlay.hide();
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: const Text("Create Blog"),
            actions: [
              GestureDetector(
                onTap: () async {
                  if (_isEdit) {
                    if (_formKey.currentState!.validate() &&
                            _selectedImages.isNotEmpty ||
                        _images.isNotEmpty) {
                      // get key from firebase

                      // create blog

                      BlogModel updatedBlog = BlogModel(
                        id: blog!.id!,
                        title: _titleController.text,
                        experience: _contentController.text,
                        image: _images.isNotEmpty ? [] : _selectedImages,
                        createdDate: blog!.createdDate,
                        updatedDate: DateTime.now(),
                        author: blog!.author,
                        like: blog!.like,
                        places: _selectedPlace,
                      );

                      await context.read<BlogCubit>().updateBlog(
                            blog: updatedBlog,
                            images: _images,
                          );
                    }
                  } else if (_formKey.currentState!.validate() &&
                      _images.isNotEmpty) {
                    // get key from firebase
                    final id =
                        FirebaseFirestore.instance.collection("blog").doc().id;
                    // create blog

                    BlogModel blog = BlogModel(
                      id: id,
                      title: _titleController.text,
                      experience: _contentController.text,
                      image: [],
                      createdDate: DateTime.now(),
                      author: kUser!,
                      like: 0,
                      places: _selectedPlace,
                      updatedDate: null,
                    );

                    await context
                        .read<BlogCubit>()
                        .createPost(blog: blog, images: _images);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.spMin,
                    vertical: 4.spMin,
                  ),
                  margin: EdgeInsets.only(right: 12.spMin),
                  decoration: BoxDecoration(
                    color: _images.isNotEmpty &&
                            _titleController.text.isNotEmpty &&
                            _contentController.text.isNotEmpty
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: kText(
                    text: _isEdit == true ? "Update" : "Create",
                    fontSize: 12,
                    color: _images.isNotEmpty &&
                            _titleController.text.isNotEmpty &&
                            _contentController.text.isNotEmpty
                        ? AppColors.white
                        : AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSearchBar(),
                          responsive.sizedBoxH20,

                          Visibility(
                            visible: _selectedPlace.isNotEmpty,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _selectedPlace.length,
                              itemBuilder: (context, index) {
                                final _sPlace = _selectedPlace[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.textFiled,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.grey),
                                  ),
                                  child: ListTile(
                                    leading: _sPlace.imageUrls != null &&
                                            _sPlace.imageUrls!.isNotEmpty
                                        ? ClipRRect(
                                            child: Image.network(
                                              _sPlace.imageUrls!.first,
                                            ),
                                          )
                                        : null,
                                    title: kText(
                                      text: _sPlace.name ?? "Name",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    subtitle: kText(
                                      text: _sPlace.address ?? "Address",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          responsive.sizedBoxH20,

                          // Add image picker
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppColors.textFiled,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: Center(
                              child: _selectedImages.isEmpty && _images.isEmpty
                                  ? IconButton(
                                      onPressed: () async {
                                        _images =
                                            await Utils.pickMultipleImages();
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.add_a_photo),
                                    )
                                  : _selectedImages.isNotEmpty &&
                                          _images.isEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _selectedImages.length,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      16,
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: _selectedImages[
                                                          index],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      _selectedImages
                                                          .removeAt(index);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _images.length,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      16,
                                                    ),
                                                    child: Image.file(
                                                      _images[index],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      _images.removeAt(index);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            onChanged: (value) => setState(() {}),
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: "Title",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title must not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) => setState(() {}),
                            controller: _contentController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: "Experience",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Experience must not be empty";
                              }
                              return null;
                            },
                          ),

                          responsive.sizedBoxH100,
                          responsive.sizedBoxH100,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // if _images is not empty show floating button to add more images in the center
              if (_images.isNotEmpty || _selectedImages.isNotEmpty)
                Positioned(
                  bottom: 100.spMin,
                  left: 100.spMin,
                  right: 100.spMin,
                  child: GestureDetector(
                    onTap: () async {
                      _images.addAll(await Utils.pickMultipleImages());
                      setState(() {});
                    },
                    child: Container(
                      // hight of the button
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.spMin),
                      height: 40.spMin,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Add more images",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
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
              onTap: () async {
                final place = await Utils.searchForPlace(context: context);
                setState(() {
                  if (place != null)
                    _selectedPlace = _selectedPlace..add(place);
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                hintText: "Search for place",
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
