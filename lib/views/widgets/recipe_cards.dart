import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souschef/controllers/chef_controller.dart';
import 'package:souschef/models/recipe.dart';
import 'package:souschef/views/app_routes.dart';

class RecipeCards extends StatelessWidget {
  final ChefController chefController = Get.put(ChefController());
  final double size;

  RecipeCards({
    super.key,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 8,
        runSpacing: 8.0,
        children: List<Widget>.generate(
          chefController.recipes.length,
          (int index) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.RECIPE,
                    arguments: chefController.recipes[index]);
              },
              hoverColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: size,
                width: size,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xCC323944),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: AutoSizeText(
                  chefController.recipes[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ).expand((widget) => [widget, SizedBox(width: 8)]).toList(),
      ),
    );
  }
}
