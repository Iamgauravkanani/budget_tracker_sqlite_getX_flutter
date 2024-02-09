import 'package:budget_tracker_app_11/modules/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpendingController extends GetxController {
  DateTime? date;
  TimeOfDay? time;
  RxString type = "".obs;
  RxString mode = "".obs;
  getDate({required DateTime dateTime}) {
    date = dateTime;
    update();
  }

  getTime({required TimeOfDay g_time}) {
    time = g_time;
    update();
  }

  getType({required String g_type}) {
    type(g_type);
  }

  getMode({required String g_mode}) {
    mode(g_mode);
  }

  Future<int?> deleteSpending({required int id}) async {
    int? res = await DBHelper.dbHelper.deleteSpending(delete_id: id);
    return res;
    update();
  }
}
