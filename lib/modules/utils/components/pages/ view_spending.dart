// ignore_for_file: unnecessary_null_comparison
import 'package:budget_tracker_app_11/modules/screens/home/controller/spending_controller.dart';
import 'package:budget_tracker_app_11/modules/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../screens/home/model/spending_model.dart';

class ViewSpending extends StatefulWidget {
  const ViewSpending({super.key});

  @override
  State<ViewSpending> createState() => _ViewSpendingState();
}

class _ViewSpendingState extends State<ViewSpending> {
  SpendingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Spending"),
      ),
      body: GetBuilder<SpendingController>(
        builder: (_) => FutureBuilder(
          future: DBHelper.dbHelper.fetchSpending(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<Spending>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Budget Tracker App",
                            content: const Text("Are you sure to delete?"),
                            confirm: OutlinedButton(
                              onPressed: () {
                                Future<int?> res = controller.deleteSpending(
                                    id: data![i].s_id!);
                                if (res != null) {
                                  Get.back();
                                  setState(() {});
                                }
                              },
                              child: const Text("Delete"),
                            ),
                            cancel: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Back"),
                            ),
                          );
                        },
                        title: Text("${data?[i].s_name}"),
                        subtitle: Text(
                            "DATE: ${data?[i].s_date}\nTIME: ${data?[i].s_time}\nTYPE: ${data?[i].s_type}\nMODE: ${data?[i].s_mode}"),
                        leading: Text("${data?[i].s_id}"),
                        trailing: Text("${data?[i].s_amount}"),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
