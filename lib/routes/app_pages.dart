import 'package:get/get.dart';
import 'package:knovator/view/page/post_dertail_screen.dart';
import 'package:knovator/view/page/post_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.postScreen,
      page: () => const PostScreen(),
    ),
    GetPage(
      name: AppRoutes.postDetailScreen,
      page: () => const PostDetailScreen(),
    ),
  ];
}
