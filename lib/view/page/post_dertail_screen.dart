import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator/controller/post_controller.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.isRegistered<PostController>() ? Get.find<PostController>() : Get.put(PostController());
    String id = Get.arguments;
    postController.getPostDetailData(id);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$id. ${postController.postDetailResponse.value.title}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              postController.postDetailResponse.value.body.toString(),
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
