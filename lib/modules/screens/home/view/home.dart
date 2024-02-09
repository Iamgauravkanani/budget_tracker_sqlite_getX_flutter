import 'package:budget_tracker_app_11/modules/screens/home/controller/navigation_controller.dart';
import 'package:budget_tracker_app_11/modules/utils/components/add_spending.dart';
import 'package:budget_tracker_app_11/modules/utils/components/pages/%20view_spending.dart';
import 'package:budget_tracker_app_11/modules/utils/components/pages/add_category.dart';
import 'package:budget_tracker_app_11/modules/utils/components/pages/view_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List<Widget> pages = [
    Add_Category(),
    addSpending(),
    View_Category(),
    ViewSpending(),
  ];
  NavigationController navigationController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: myCallBack,
          selectedIndex: navigationController.navigation.selectedIndex.toInt(),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.category), label: "Add Category"),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: "Add Spending",
            ),
            NavigationDestination(
              icon: Icon(Icons.view_agenda_outlined),
              label: "view Category",
            ),
            NavigationDestination(
              icon: Icon(Icons.view_agenda_outlined),
              label: "view Spending",
            ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: myCallBack,
        controller: navigationController.pageController,
        children: pages,
      ),
    );
  }

  myCallBack(val) {
    navigationController.changePage(val: val);
  }
}
