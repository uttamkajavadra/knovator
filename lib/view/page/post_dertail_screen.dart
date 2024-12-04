import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator/controller/post_controller.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostController postController = Get.isRegistered<PostController>() ? Get.find<PostController>() : Get.put(PostController());
  String id = Get.arguments;
  @override
  void initState() {
    postController.getPostDetailData(id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: postController.getPostDetailData(id),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$id. ${snapshot.data!.title}",
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot.data!.body.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
