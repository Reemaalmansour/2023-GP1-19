import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novoy/model/blog/blog_model.dart';
import 'package:novoy/shared/component/k_text.dart';
import 'package:novoy/shared/utils/utils.dart';

import '../blog_details.dart';

class BlogCard extends StatefulWidget {
  final BlogModel blog;
  const BlogCard({super.key, required this.blog});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  late BlogModel blog = widget.blog;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlogDetails(blog: blog),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // bottom border only
          border: const Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // cursoal image

            Container(
              height: 200.spMin,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.05),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: blog.image != null && blog.image!.isNotEmpty
                      ? blog.image!.first
                      : "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            // blog title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
              child: kText(
                text: blog.title ?? "",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // author  data
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: blog.createdDate!,
                    // author image or first letter of name
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: blog.author.imageUrl != null
                          ? CachedNetworkImageProvider(blog.author.imageUrl!)
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
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.author.name ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // formate date time to string
                      kText(
                        text: Utils.timeAgo(blog.createdDate!),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
