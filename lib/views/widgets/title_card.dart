import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String text;

  const TitleCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(text);
      },
      hoverColor: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 200,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xCC323944),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          minFontSize: 20,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
