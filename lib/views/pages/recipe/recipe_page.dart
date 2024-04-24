import 'package:flutter/material.dart';
import 'package:souschef/controllers/active_recipe_controller.dart';
import 'package:souschef/controllers/chef_controller.dart';
import 'package:souschef/models/recipe.dart';
import 'package:souschef/views/pages/recipe/step_section.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:get/get.dart';

class RecipePage extends StatelessWidget {
  ChefController chefController = Get.put(ChefController());
  late ActiveRecipeController activeRecipeController;

  RecipePage({super.key});

  Color getColor(int estimatedTime) {
    if (estimatedTime <= 9) {
      return Color(0xFF238500);
    } else if (estimatedTime <= 16) {
      return Color(0xFF6A6600);
    }
    return Color(0xFF905700);
  }

  Widget buildStepIcon(int activeStep, CookingStep stepInfo) {
    Color color = Colors.blue;
    if (stepInfo.stepNumber == 0) {
      color = Colors.blue;
    } else if (stepInfo.stepNumber <= activeStep) {
      color = getColor(stepInfo.estimatedTimeMinutes);
    } else if (activeStep < stepInfo.stepNumber) {
      color = Colors.grey;
    }

    return Flexible(
      flex: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 100),
        child: Container(
          margin: EdgeInsets.only(right: 12),
          height: 15,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: getColor(stepInfo.estimatedTimeMinutes),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget buildStepIcons() {
    return Obx(() {
      final getCurrentStepNum =
          activeRecipeController.getCurrentStepNum().value;
      final List<Widget> stepIcons = [
        buildStepIcon(
          getCurrentStepNum,
          CookingStep(
            stepNumber: 0,
            title: "Prepare Equipment",
            equipmentNeeded: [],
            instructions: "Gather all the equipments.",
            ingredientsUsed: [],
            estimatedTimeMinutes: 0,
            definitionOfDone: "Materials Gathered",
          ),
        ),
        ...activeRecipeController.recipe.steps
            .map((stepInfo) => buildStepIcon(getCurrentStepNum, stepInfo)),
      ];

      return SizedBox(
        height: 20,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: stepIcons,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Recipe data = Get.arguments as Recipe;
    print(data);
    activeRecipeController = Get.put(ActiveRecipeController(data));

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 50, horizontal: 100),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStepIcons(),
              SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: StepSection(
                      stepInfo: activeRecipeController.getCurrentStep()),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    activeRecipeController.currentStepNum.value > 0
                        ? TextButton(
                            style: TextButton.styleFrom(),
                            onPressed: () {
                              activeRecipeController.goToPreviousStep();
                            },
                            child: Text(
                              "Previous Step",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(width: 10),
                    Obx(
                      () {
                        return activeRecipeController.currentStepNum.value + 1 <
                                activeRecipeController.getTotalStepCount()
                            ? SizedBox(
                                height: 70,
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    backgroundColor: Color(0xFF43927D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    activeRecipeController.goToNextStep();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        activeRecipeController
                                                    .getCurrentStepNum()
                                                    .value ==
                                                0
                                            ? "Start Cooking"
                                            : "Next Step",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      activeRecipeController
                                                  .getCurrentStepNum()
                                                  .value ==
                                              0
                                          ? Icon(
                                              FeatherIcons.arrowRight,
                                              color: Colors.white,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
