import 'package:flutter/material.dart';

import '../../core/color_manager.dart';
import '../../core/text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.hasIcon = false,  this.color=ColorManager.primaryColor,
  });

  final Function()? onPressed;
  final String text;
  final bool hasIcon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: mainTextStyle.copyWith(fontSize: 14),
          ),
          if (hasIcon)
            const SizedBox(
              width: 10,
            ),
          if (hasIcon)
            const Icon(
              Icons.arrow_forward_ios,
              size: 10,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
