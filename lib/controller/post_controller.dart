// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:knovator/db_handler/post_helper.dart';
import 'package:knovator/model/post_model.dart';
import 'package:knovator/service/api_manager.dart';
import 'package:knovator/service/endpoints.dart';

class PostController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPostData();
  }

  List<RxInt> timerCount = [];
  List<Timer> timerDuration = [];

  void startTimer(int index) {
    timerDuration[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCount[index].value += 1;
    });
  }

  void pauseTimer(int index) {
    timerDuration[index].cancel();
  }

  RxList<PostModel> postResponse = <PostModel>[].obs;
  PostHelper postHelper = PostHelper();

  Future<void> getDBData() async {
    await postHelper.get().then((val) {
      if (val.isNotEmpty) {
        var body = jsonEncode(val);
        var data = jsonDecode(body) as List;
        postResponse.value = data.map((e) => PostModel.fromJson(e)).toList();
        timerCount = List.generate(postResponse.value.length, (index) => 0.obs);
        timerDuration = List.generate(postResponse.value.length, (index) => Timer(const Duration(seconds: 1), () {}));
      }
    });
  }

  Future<void> getPostData() async {
    try {
      getDBData();
      final response = await ApiManager.instance.get(Endpoints.post);
      var data = jsonDecode(response.body) as List;
      List<PostModel> tempResponse = data.map((e) => PostModel.fromJson(e)).toList();
      for (int i = 0; i < tempResponse.length; i++) {
        postHelper.postDataAvailable(tempResponse[i].id ?? 0).then((status) {
          if (!status) {
            postHelper.insert(PostModel(
                id: tempResponse[i].id, userId: tempResponse[i].userId, title: tempResponse[i].title, body: tempResponse[i].body, markAsRead: 0));
            postResponse.add(PostModel(
                id: tempResponse[i].id, userId: tempResponse[i].userId, title: tempResponse[i].title, body: tempResponse[i].body, markAsRead: 0));
            timerCount.add(0.obs);
            timerDuration.add(Timer(const Duration(seconds: 1), () {}));
            update();
          }
        });
      }
      update();
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  void setMarkAsRead(int index, int id, int userId, String title, String body) {
    postHelper.update(PostModel(id: id, userId: userId, title: title, body: body, markAsRead: 1), id);
    postResponse[index].markAsRead = 1;
  }

  Rx<PostModel> postDetailResponse = PostModel().obs;
  Future<void> getPostDetailData(String id) async {
    try {
      final response = await ApiManager.instance.get("${Endpoints.post}/$id");
      var data = jsonDecode(response.body);
      postDetailResponse.value = PostModel.fromJson(data);
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}
