import 'package:get/get.dart';
import 'package:souschef/models/recipe.dart';

class ActiveRecipeController extends GetxController {
  late Recipe recipe;
  RxInt currentStepNum = 0.obs;

  ActiveRecipeController(Recipe activeRecipe) {
    recipe = activeRecipe;
  }

  getTotalStepCount() => recipe.steps.length + 1;

  getRecipe() => recipe;

  getCurrentStepNum() => currentStepNum;

  getCurrentStep() {
    if (currentStepNum.value == 0) {
      return CookingStep(
        stepNumber: 0,
        title: "Prepare Equipment",
        equipmentNeeded: recipe.allEquipmentNeeded,
        instructions: "Gather all the equipments.",
        ingredientsUsed: recipe.ingredients,
        estimatedTimeMinutes: recipe.totalTimeMinutes,
        definitionOfDone: "Materials Gathered",
      );
    }
    return recipe.steps.firstWhere(
      (stepInfo) {
        return stepInfo.stepNumber == currentStepNum.value;
      },
    );
  }

  goToNextStep() => currentStepNum++;

  goToPreviousStep() => currentStepNum--;

  goToStep(int stepNum) => currentStepNum.value = stepNum;
}
