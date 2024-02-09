import 'dart:typed_data';
import 'package:budget_tracker_app_11/modules/screens/home/model/category_model.dart';
import 'package:budget_tracker_app_11/modules/screens/home/view/home.dart';
import 'package:budget_tracker_app_11/modules/screens/update_cat/%20controller/update_controller.dart';
import 'package:budget_tracker_app_11/modules/utils/asset/asset.dart';
import 'package:budget_tracker_app_11/modules/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Update extends StatelessWidget {
  Update({super.key});

  TextEditingController textEditingController = TextEditingController();

  String? category_name;

  ByteData? byteData;
  UpdateController controller = Get.put(UpdateController());
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Uint8List? cat_image = await byteData?.buffer.asUint8List();

          int? res = await DBHelper.dbHelper.updateCategory(
            name: category_name!,
            image: cat_image!,
            id: id,
          );
          Get.snackbar('Budget Tracker App', 'Category Updated at $res');
          Get.offAll(Home());
          textEditingController.clear();
        },
        label: const Text('Update category'),
        icon: const Icon(Icons.category_outlined),
      ),
      appBar: AppBar(
        title: const Text("Update Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              onChanged: (val) {
                category_name = val;
              },
              decoration: const InputDecoration(
                hintText: "enter category here.....",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: Asset.cat_images.length,
                  itemBuilder: (ctx, i) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () async {
                          byteData = await rootBundle.load(Asset.cat_images[i]);
                          controller.changeIndex(i: i);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: (controller.update_i.selectedIndex == i)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            image: DecorationImage(
                              image: AssetImage(Asset.cat_images[i]),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
