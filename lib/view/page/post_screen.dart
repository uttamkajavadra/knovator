import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator/controller/post_controller.dart';
import 'package:knovator/routes/app_routes.dart';
import 'package:knovator/view/widget/custom_post.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.isRegistered<PostController>() ? Get.find<PostController>() : Get.put(PostController());
    return Scaffold(
      body: Obx(() {
        if (postController.postResponse.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: postController.postResponse.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return VisibilityDetector(
                key: Key(index.toString()),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0) {
                    postController.startTimer(index);
                  } else {
                    postController.pauseTimer(index);
                  }
                },
                child: GestureDetector(
                    onTap: () {
                      postController.setMarkAsRead(index, postController.postResponse[index].id ?? 0, postController.postResponse[index].userId ?? 0,
                          postController.postResponse[index].title ?? "", postController.postResponse[index].body ?? "");
                      Get.toNamed(AppRoutes.postDetailScreen, arguments: postController.postResponse[index].id.toString());
                    },
                    child: CustomPost(
                        id: postController.postResponse[index].id.toString(),
                        title: postController.postResponse[index].title.toString(),
                        second: postController.timerCount[index].value,
                        markAsRead: postController.postResponse[index].markAsRead ?? 0)),
              );
            });
          },
        );
      }),
    );
  }
}
