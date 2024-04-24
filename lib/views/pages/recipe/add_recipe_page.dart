import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souschef/controllers/chef_controller.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:souschef/views/app_routes.dart';

class AddRecipePage extends StatefulWidget {
  AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _controller = TextEditingController();
  final ChefController chefController = Get.put(ChefController());

  @override
  void dispose() async {
    // Dispose the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  void handleClick(String userText) async {
    await chefController.requestRecipe(userText);
    Get.toNamed(Routes.HOME);
  }

  Widget buildButton(Function() onClick) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          backgroundColor: Color(0xFF43927D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => onClick(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Generate Recipe",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Icon(
              FeatherIcons.arrowRight,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Add a new recipe!",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Text(
                "Link to Recipe",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _controller,
              ),
              const SizedBox(height: 20),
              buildButton(() => handleClick(_controller.text)),
            ],
          ),
        ),
      ),
    );
  }
}
