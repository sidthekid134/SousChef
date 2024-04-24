import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souschef/models/recipe.dart';

class IngredientCards extends StatelessWidget {
  final List<Ingredient?> ingredientsList;

  const IngredientCards({
    super.key,
    required this.ingredientsList,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8.0,
      children: List<Widget>.generate(
        ingredientsList.length,
        (int index) {
          return InkWell(
            onTap: () {
              print(ingredientsList[index]?.name);
            },
            hoverColor: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xCC323944),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        ingredientsList[index]!.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: AutoSizeText(
                      ingredientsList[index]!.quantity,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      minFontSize: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).expand((widget) => [widget, SizedBox(width: 8)]).toList(),
    );
  }
}
