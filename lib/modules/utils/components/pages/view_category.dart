import 'package:budget_tracker_app_11/modules/screens/home/model/category_model.dart';
import 'package:budget_tracker_app_11/modules/screens/update_cat/views/update_cat.dart';
import 'package:budget_tracker_app_11/modules/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class View_Category extends StatelessWidget {
  View_Category({super.key});

  TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchCon,
              decoration: const InputDecoration(
                hintText: 'search here',
                label: Text('search '),
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: DBHelper.dbHelper.searchCategory(searchData: 'a'),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Category>? category = snapshot.data;
                    return ListView.builder(
                        itemCount: category?.length,
                        itemBuilder: (ctx, i) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Get.defaultDialog(
                                  title: 'Budget Tracker App',
                                  content: const Text(
                                      "Are you Sure to Delete Category ??"),
                                  cancel: OutlinedButton(
                                    onPressed: () {
                                      Get.offAll(Update(),
                                          arguments: category[i].id!);
                                    },
                                    child: const Text("Update"),
                                  ),
                                  confirm: OutlinedButton(
                                    onPressed: () {
                                      DBHelper.dbHelper
                                          .deleteQuery(id: category[i].id!);
                                    },
                                    child: const Text("Delete"),
                                  ),
                                );
                              },
                              title: Text("${category?[i].cat_name}"),
                              leading: CircleAvatar(
                                backgroundImage:
                                    MemoryImage(category![i].cat_image),
                              ),
                              trailing: Text("${category[i].id?.toInt()}"),
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
          ],
        ),
      ),
    );
  }
}
