
import 'package:baymax/core/color_manager.dart';
import 'package:baymax/core/navigation_functions.dart';
import 'package:baymax/pages/help_page.dart';
import 'package:baymax/pages/questions_page.dart';

import 'package:baymax/pages/upolad_image_page.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: "logo",
            child: Image.asset(
              "assets/logo.png",
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          
          CustomButtonWidget(
            onPressed: () {
              navigateTo(context, const  QuestionsPage());
            },
            text: "Symptoms",
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonWidget(
            text: "ECG",
            onPressed: () {
              navigateTo(context, const UploadImagePage());
            },
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        navigateTo(context, const HelpPage());
      },
      shape: const CircleBorder(),
      backgroundColor: ColorManager.primaryColor,
      child: const Icon(Icons.help_outline_rounded,color: Colors.white,size: 40,),
    ),
    );
  }
}
