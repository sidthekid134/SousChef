import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:souschef/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

class ChefController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final client = OpenAIClient(apiKey: '');
  final RxList<Recipe> recipes = <Recipe>[].obs;
  late String recipeJsonlSchema;

  @override
  void onInit() async {
    super.onInit();
    // Add code to run on initialization here
    final String recipeJsonSchema =
        await loadAsset('assets/json/recipe-schema.json');
    recipeJsonlSchema = recipeJsonSchema.replaceAll(RegExp(r'\s'), '');

    // Load existing recipes
    recipes.addAll(await getAllRecipes());
  }

  Future<List<Recipe>> getAllRecipes() async {
    QuerySnapshot snapshot = await firestore.collection('recipes').get();

    List<Recipe> recipes = snapshot.docs.map((doc) {
      return Recipe.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return recipes;
  }

  requestRecipe(String userText) async {
    print("started Processing");
    final llmResponse = await client.createChatCompletion(
      request: CreateChatCompletionRequest(
        maxTokens: 4096,
        model: ChatCompletionModel.modelId('gpt-4-turbo'),
        messages: [
          ChatCompletionMessage.system(
            content:
                'Consider this schema: $recipeJsonlSchema When provided with a recipe name, link, or the recipe content itself, you will do the following steps and return just the output to step 4: 1. Generate the recipe 2. Modify the recipe so it is split step by step so a human can easily follow it. Each step should be very specific actions that can be done together and easily. Every step will always have the ingredients that are used in that step. Make sure you fill out as many fields as you can in the schema. 3. Convert the recipe text to a JSON format following the schema provided. 4. Return just the JSON response without whitespaces',
          ),
          ChatCompletionMessage.user(
            content: ChatCompletionUserMessageContent.string(
                'Give me the recipe for: $userText'),
          ),
        ],
        temperature: 0,
        responseFormat: ChatCompletionResponseFormat(
          type: ChatCompletionResponseFormatType.jsonObject,
        ),
      ),
    );

    var rawResponse = llmResponse.choices.first.message.content;
    if (rawResponse == null || rawResponse.isEmpty) {
      return;
    }
    // Convert llm response to json
    dynamic recipeJSON = json.decode(rawResponse);

    // Add id to recipe
    var uuid = Uuid();
    var v4Uuid = uuid.v4();
    recipeJSON["id"] = v4Uuid;

    // Convert to recipe dart object
    Recipe recipe = Recipe.fromJson(recipeJSON);

    // Add to firestore
    await firestore
        .collection('recipes')
        .doc(recipe.id)
        .set(recipe.toJson())
        .then((_) => print('Recipe added'))
        .catchError((error) => throw error);
    return recipes.add(recipe);
  }

  getRecipe(String id) => recipes.firstWhere((recipe) => recipe.id == id);
}
