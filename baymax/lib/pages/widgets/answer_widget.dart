
import 'package:flutter/material.dart';

import '../../core/color_manager.dart';
import '../../core/text_style.dart';

class AnswersWidget extends StatelessWidget {
  const AnswersWidget({
    super.key,
    required this.answer,
    required this.isChosen,
    required this.index,
    this.onPressed,
  });

  final String answer;
  final Function()? onPressed;
  final bool isChosen;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:isChosen? Colors.white: ColorManager.primaryColor.withOpacity(0.5),
                border: Border.all(
                  color: isChosen
                      ? ColorManager.primaryColor
                      : Colors.transparent,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 0),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      answer,
                      style: mainTextStyle.copyWith(
                         color:isChosen? Colors.black: Colors.white,
                      ),
                    ),
                  ),
                  if (isChosen)
                   const Icon(Icons.check_circle_outline,
                        color: ColorManager.primaryColor)
                ],
              ),
            )),
      ),
    );
  }
}
