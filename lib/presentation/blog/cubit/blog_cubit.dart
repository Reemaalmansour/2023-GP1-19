import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:novoy/global/global.dart';
import 'package:novoy/model/blog/blog_model.dart';
import 'package:novoy/shared/utils/utils.dart';

part 'blog_cubit.freezed.dart';
part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  /// Private constructor
  BlogCubit._privateConstructor() : super(const BlogState.initial());

  // Static instance variable
  static final BlogCubit _instance = BlogCubit._privateConstructor();

  // Getter to access the instance
  static BlogCubit get instance => _instance;

  final _fb = FirebaseFirestore.instance;

  List<BlogModel> _blogs = [];
  List<BlogModel> _myBlogs = [];

  List<BlogModel> get blogs => _blogs;
  List<BlogModel> get myBlogs => _myBlogs;

  Future<void> createPost({
    required BlogModel blog,
    required List<File> images,
  }) async {
    BlogModel? uBlog;
    emit(const BlogState.createBlogLoading());
    try {
      final imageList = await Utils.uploadImages(
        images: images,
      );
      log("Image List: $imageList");
      uBlog = blog.copyWith(
        image: imageList,
        createdDate: DateTime.now(),
      );
      // Add your logic here
      await _fb.collection("blog").doc(uBlog.id!).set(uBlog.toJson());
    } catch (e) {
      log("Error: $e");
      emit(const BlogState.createBlogFailed());
    } finally {
      _blogs.insert(0, uBlog!);
      emit(const BlogState.createBlogSuccess());
    }
  }

  // fetch all blogs
  Future<void> fetchBlogs() async {
    emit(const BlogState.fetchBlogLoading());
    try {
      final data = await _fb.collection("blog").get();
      _blogs = data.docs.map((e) => BlogModel.fromJson(e.data())).toList();
      _myBlogs =
          _blogs.where((element) => element.author.uId == kUser!.uId!).toList();
      emit(
        BlogState.fetchBlogSuccess(
          blogs: _blogs,
        ),
      );
    } catch (e) {
      emit(const BlogState.fetchBlogFailed());
    }
  }

  // fetch my blogs only
  Future<void> fetchMyBlogs({
    bool? forceRefresh = false,
  }) async {
    emit(const BlogState.fetchMyBlogLoading());
    try {
      if (_blogs.isEmpty || forceRefresh!) {
        final data = await _fb.collection("blog").get();
        _blogs = data.docs.map((e) => BlogModel.fromJson(e.data())).toList();
      }
      _myBlogs =
          _blogs.where((element) => element.author.uId == kUser!.uId!).toList();
      emit(
        BlogState.fetchMyBlogSuccess(
          blogs: _myBlogs,
        ),
      );
    } catch (e) {
      emit(const BlogState.fetchMyBlogFailed());
    }
  }

  // update blog
  Future<void> updateBlog({
    required BlogModel blog,
    required List<File>? images,
  }) async {
    BlogModel? uBlog;
    emit(const BlogState.updateBlogLoading());
    try {
      List<String> imageList = [];
      if (images != null && images.isNotEmpty) {
        imageList = await Utils.uploadImages(
          images: images,
        );
        log("Image List: $imageList");
        uBlog = blog.copyWith(
          image: imageList,
          updatedDate: DateTime.now(),
        );
      } else {
        uBlog = blog.copyWith(
          updatedDate: DateTime.now(),
        );
      }

      // Add your logic here
      await _fb.collection("blog").doc(blog.id).update(uBlog.toJson());
    } catch (e) {
      log("Error: $e");
      emit(const BlogState.updateBlogFailed());
    } finally {
      _blogs.removeWhere((element) => element.id == blog.id);
      _blogs.insert(0, uBlog!);
      _myBlogs =
          _blogs.where((element) => element.author.uId == kUser!.uId!).toList();
      emit(const BlogState.updateBlogSuccess());
    }
  }

  // delete blog
  Future<void> deleteBlog({
    required BlogModel blog,
  }) async {
    emit(const BlogState.deleteBlogLoading());
    try {
      // Add your logic here
      await _fb.collection("blog").doc(blog.id).delete();
    } catch (e) {
      emit(const BlogState.deleteBlogFailed());
    } finally {
      _blogs.removeWhere((element) => element.id == blog.id);
      _myBlogs =
          _blogs.where((element) => element.author.uId == kUser!.uId!).toList();
      emit(const BlogState.deleteBlogSuccess());
    }
  }
}
