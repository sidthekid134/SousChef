import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souschef/views/app_routes.dart';
import 'package:souschef/views/widgets/recipe_cards.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hey Sid, let's get cooking!",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              children: [
                Text(
                  'Recipes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                    icon: Icon(FeatherIcons.plusCircle),
                    onPressed: () {
                      Get.toNamed(Routes.ADD_RECIPE);
                    })
              ],
            ),
            SizedBox(height: 20),
            RecipeCards(size: 140),
          ],
        ),
      ),
    );
  }
}
