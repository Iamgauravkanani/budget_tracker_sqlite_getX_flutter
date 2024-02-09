import 'package:budget_tracker_app_11/modules/screens/home/model/navigation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  Navigation navigation = Navigation(selectedIndex: 0.obs);
  PageController pageController = PageController();

  void changePage({required int val}) {
    navigation.selectedIndex(val);
    pageController.animateToPage(val,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}
