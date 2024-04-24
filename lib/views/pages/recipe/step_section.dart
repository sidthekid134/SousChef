import 'package:flutter/material.dart';
import 'package:souschef/models/recipe.dart';
import 'package:souschef/views/widgets/ingredient_cards.dart';
import 'package:souschef/views/widgets/title_cards.dart';

class StepSection extends StatelessWidget {
  final CookingStep stepInfo;

  const StepSection({super.key, required this.stepInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Step ${stepInfo.stepNumber}: ${stepInfo.title}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            Chip(
              color: MaterialStateProperty.resolveWith((states) {
                if (stepInfo.estimatedTimeMinutes <= 9) {
                  return Color(0xFF238500);
                } else if (stepInfo.estimatedTimeMinutes <= 16) {
                  return Color(0xFF6A6600);
                }
                return Color(0xFF905700);
              }),
              label: Text('${stepInfo.estimatedTimeMinutes} minutes'),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          decoration: BoxDecoration(
            color: Color(0xCC323944),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            stepInfo.instructions,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Text(
          "Pots & Pans",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        TitleCards(
          titleList: stepInfo.equipmentNeeded,
          onClick: (e) {},
          size: 100,
        ),
        const SizedBox(height: 20),
        Text(
          "Ingredients",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        IngredientCards(
          ingredientsList: stepInfo.ingredientsUsed,
        ),
      ],
    );
  }
}
