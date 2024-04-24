import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleCards extends StatelessWidget {
  final List<String?> titleList;
  final double size;
  final Function(String) onClick;

  const TitleCards({
    super.key,
    required this.titleList,
    required this.onClick,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8.0,
      children: List<Widget>.generate(
        titleList.length,
        (int index) {
          return InkWell(
            onTap: () {
              print(titleList[index]);
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
                titleList[index]!,
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
    );
  }
}
