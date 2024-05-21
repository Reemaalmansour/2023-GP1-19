part of 'blog_cubit.dart';

@freezed
class BlogState with _$BlogState {
  const factory BlogState.initial() = _Initial;

  // create blog Loading
  const factory BlogState.createBlogLoading() = _CreatePostLoading;

  // blog created successfully
  const factory BlogState.createBlogSuccess() = _CreatePostSuccess;

  // blog created failed
  const factory BlogState.createBlogFailed() = _CreatePostFailed;

  // fetch blog loading
  const factory BlogState.fetchBlogLoading() = _FetchBlogLoading;

  // fetch blog success
  const factory BlogState.fetchBlogSuccess({
    required List<BlogModel> blogs,
  }) = _FetchBlogSuccess;

  // fetch blog failed
  const factory BlogState.fetchBlogFailed() = _FetchBlogFailed;

  // fetch my blog loading
  const factory BlogState.fetchMyBlogLoading() = _FetchMyBlogLoading;

  // fetch my blog success
  const factory BlogState.fetchMyBlogSuccess({
    required List<BlogModel> blogs,
  }) = _FetchMyBlogSuccess;

  // fetch my blog failed
  const factory BlogState.fetchMyBlogFailed() = _FetchMyBlogFailed;

  // delete blog loading
  const factory BlogState.deleteBlogLoading() = _DeleteBlogLoading;

  // delete blog success
  const factory BlogState.deleteBlogSuccess() = _DeleteBlogSuccess;

  // delete blog failed
  const factory BlogState.deleteBlogFailed() = _DeleteBlogFailed;

  // update blog loading
  const factory BlogState.updateBlogLoading() = _UpdateBlogLoading;

  // update blog success
  const factory BlogState.updateBlogSuccess() = _UpdateBlogSuccess;

  // update blog failed
  const factory BlogState.updateBlogFailed() = _UpdateBlogFailed;
}
