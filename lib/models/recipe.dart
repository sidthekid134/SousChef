class Recipe {
  final String id;
  final String title;
  final String servings;
  final int totalTimeMinutes;
  final int? activeTimeMinutes;
  final int? passiveTimeMinutes;
  final Metadata metadata;
  final List<Ingredient> ingredients;
  final List<CookingStep> steps;
  final List<String>
      allEquipmentNeeded; // New field to store all unique equipment

  Recipe({
    required this.id,
    required this.title,
    required this.servings,
    required this.totalTimeMinutes,
    required this.activeTimeMinutes,
    required this.passiveTimeMinutes,
    required this.metadata,
    required this.ingredients,
    required this.steps,
  }) : allEquipmentNeeded = _getAllEquipmentNeeded(steps);

  // Private method to compute all unique equipment needed from all steps
  static List<String> _getAllEquipmentNeeded(List<CookingStep> steps) {
    final equipmentSet = <String?>{};
    for (CookingStep step in steps) {
      equipmentSet.addAll(step.equipmentNeeded);
    }
    return List<String>.from(equipmentSet);
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      servings: json['servings'],
      totalTimeMinutes: json['totalTimeMinutes'],
      activeTimeMinutes: json['activeTimeMinutes'],
      passiveTimeMinutes: json['passiveTimeMinutes'],
      metadata: Metadata.fromJson(json['metadata']),
      ingredients: List<Ingredient>.from(
          json['ingredients'].map((i) => Ingredient.fromJson(i))),
      steps: List<CookingStep>.from(
          json['steps'].map((s) => CookingStep.fromJson(s))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'servings': servings,
      'totalTimeMinutes': totalTimeMinutes,
      'activeTimeMinutes': activeTimeMinutes,
      'passiveTimeMinutes': passiveTimeMinutes,
      'metadata': metadata.toJson(),
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'steps': steps.map((s) => s.toJson()).toList(),
      'allEquipmentNeeded': allEquipmentNeeded,
    };
  }
}

class Metadata {
  final String cuisine;
  final String dishType;
  final String difficultyLevel;

  Metadata({
    required this.cuisine,
    required this.dishType,
    required this.difficultyLevel,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      cuisine: json['cuisine'],
      dishType: json['dishType'],
      difficultyLevel: json['difficultyLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cuisine': cuisine,
      'dishType': dishType,
      'difficultyLevel': difficultyLevel,
    };
  }
}

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({
    required this.name,
    required this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}

class CookingStep {
  final int stepNumber;
  final String title;
  final List<String> equipmentNeeded;
  final String instructions;
  final List<Ingredient> ingredientsUsed;
  final int estimatedTimeMinutes;
  final String definitionOfDone;

  CookingStep({
    required this.stepNumber,
    required this.title,
    required this.equipmentNeeded,
    required this.instructions,
    required this.ingredientsUsed,
    required this.estimatedTimeMinutes,
    required this.definitionOfDone,
  });

  factory CookingStep.fromJson(Map<String, dynamic> json) {
    return CookingStep(
      stepNumber: json['stepNumber'] ?? 0,
      title: json['title'] ?? '',
      equipmentNeeded: json['equipmentNeeded'] != null
          ? List<String>.from(json['equipmentNeeded'])
          : [],
      instructions: json['instructions'] ?? '',
      ingredientsUsed: json['ingredientsUsed'] != null
          ? List<Ingredient>.from(
              json['ingredientsUsed'].map((i) => Ingredient.fromJson(i ?? {})))
          : [],
      estimatedTimeMinutes: json['estimatedTimeMinutes'] ?? 0,
      definitionOfDone: json['definitionOfDone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'title': title,
      'equipmentNeeded': equipmentNeeded,
      'instructions': instructions,
      'ingredientsUsed': ingredientsUsed.map((i) => i.toJson()).toList(),
      'estimatedTimeMinutes': estimatedTimeMinutes,
      'definitionOfDone': definitionOfDone,
    };
  }
}
