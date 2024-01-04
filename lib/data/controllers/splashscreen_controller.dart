import 'package:get/get.dart';
import 'package:z_test/data/data/auth_local_datasource.dart';
import 'package:z_test/presentation/auth/pages/login_register_page.dart';

import '../../presentation/home/pages/dashboard_page.dart';
import '../models/auth_model.dart';

void checkLoginStatus() async {
  await Future.delayed(Duration(seconds: 4));

  Auth? currentUser = await DatabaseHelper.instance.getCurrentUser();

  if (currentUser != null && currentUser.token == 1) {
    Get.off(
      () => Dashboard(user: currentUser),
      transition: Transition.fadeIn,
    );
  } else {
    Get.off(
      () => LoginPage(),
      transition: Transition.fadeIn,
    );
  }
}
