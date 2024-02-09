import 'package:budget_tracker_app_11/modules/screens/update_cat/model/update_model.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  Update update_i = Update(selectedIndex: 0.obs);

  void changeIndex({required int i}) {
    update_i.selectedIndex = i.obs;
  }
}
