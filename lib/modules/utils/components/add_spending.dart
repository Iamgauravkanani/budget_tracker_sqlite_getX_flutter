import 'dart:developer';
import 'package:budget_tracker_app_11/modules/screens/home/controller/spending_controller.dart';
import 'package:budget_tracker_app_11/modules/screens/home/model/spending_model.dart';
import 'package:budget_tracker_app_11/modules/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addSpending extends StatelessWidget {
  addSpending({super.key});
  TextEditingController nameCon = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  String? name;
  String? amount;
  SpendingController controller = Get.put(SpendingController());
  @override
  Widget build(BuildContext context) {
    addSpending() async {
      Spending spending = Spending(
        s_amount: amount!,
        s_date:
            "${controller.date?.day}/${controller.date?.month}/${controller.date?.year}",
        s_name: name!,
        s_mode: controller.mode.toString(),
        s_time: "${controller.time?.hour}:${controller.time?.minute}",
        s_type: controller.type.toString(),
      );
      int? res = await DBHelper.dbHelper.insertSpending(spending: spending);
      log("Data Inserted to $res");
      nameCon.clear();
      amountCon.clear();
    }

    spending_type(val) {
      controller.getType(g_type: val);
      log("${controller.type}");
    }

    spending_mode(val) {
      controller.getMode(g_mode: val);
      log("${controller.mode}");
    }

    pickDate() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2001),
        lastDate: DateTime(2040),
      );
      controller.getDate(dateTime: pickedDate!);
    }

    pickTime() async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      controller.getTime(g_time: pickedTime!);
    }

    nameVal(val) {
      name = val;
    }

    amountVal(val) {
      amount = val;
    }

    TextStyle myTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    // ignore: prefer_const_constructors
    OutlineInputBorder outlineInputBorder() => OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
        );
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Add Spending"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameCon,
              onChanged: nameVal,
              decoration: InputDecoration(
                fillColor: Colors.green[100],
                filled: true,
                hintText: 'enter name ...',
                border: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: false,
              keyboardType: TextInputType.number,
              controller: amountCon,
              onChanged: amountVal,
              decoration: InputDecoration(
                fillColor: Colors.green[100],
                filled: true,
                hintText: 'enter amount ...',
                border: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
              ),
            ),
            GetBuilder<SpendingController>(
              builder: (_) => Row(
                children: [
                  IconButton(
                    onPressed: pickDate,
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 30,
                    ),
                  ),
                  (controller.date == null)
                      ? Text(
                          "Pick a Date",
                          style: myTextStyle,
                        )
                      : Text(
                          "${controller.date?.day}/${controller.date?.month}/${controller.date?.year}",
                          style: myTextStyle,
                        )
                ],
              ),
            ),
            GetBuilder<SpendingController>(
              builder: (_) => Row(
                children: [
                  IconButton(
                    onPressed: pickTime,
                    icon: const Icon(
                      Icons.watch,
                      size: 30,
                    ),
                  ),
                  (controller.time == null)
                      ? Text(
                          "Pick a Time",
                          style: myTextStyle,
                        )
                      : GetBuilder<SpendingController>(
                          builder: (_) => Text(
                            "${controller.time?.hour}:${controller.time?.minute}",
                            style: myTextStyle,
                          ),
                        )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      value: 'Cash',
                      groupValue: controller.mode.toString(),
                      onChanged: spending_mode,
                      title: Text(
                        "Cash",
                        style: myTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      value: 'Online',
                      groupValue: controller.mode.toString(),
                      onChanged: spending_mode,
                      title: Text(
                        "Online",
                        style: myTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      value: 'Income',
                      groupValue: controller.type.toString(),
                      onChanged: spending_type,
                      title: Text(
                        "Income",
                        style: myTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      value: 'Expence',
                      groupValue: controller.type.toString(),
                      onChanged: spending_type,
                      title: Text(
                        "Expence",
                        style: myTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: addSpending,
              icon: const Icon(Icons.done_all),
              label: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
