import 'package:budget_tracker_app_11/modules/screens/home/controller/category_controller.dart';
import 'package:budget_tracker_app_11/modules/screens/home/model/category_model.dart';
import 'package:budget_tracker_app_11/modules/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../asset/asset.dart';

class Add_Category extends StatelessWidget {
  Add_Category({super.key});
  TextEditingController textEditingController = TextEditingController();
  String? category_name;
  ByteData? byteData;
  CategoryController controller = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Uint8List? cat_image = byteData?.buffer.asUint8List();

          Category category = Category(
            cat_name: category_name!,
            cat_image: cat_image!,
          );

          //todo:insert method call
          int? res = await DBHelper.dbHelper.insertCategory(category: category);
          Get.snackbar('Budget Tracker App', 'Category Inserted at $res');
          textEditingController.clear();
        },
        label: const Text('add category'),
        icon: const Icon(Icons.category_outlined),
      ),
      appBar: AppBar(
        title: const Text("Add Category"),
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
                    return GestureDetector(
                      onTap: () async {
                        byteData = await rootBundle.load(Asset.cat_images[i]);

                        controller.changeIndex(i: i);
                      },
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: (controller.selectedIndex == i)
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
