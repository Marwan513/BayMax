import 'dart:io';

import 'package:baymax/manager/questions_cubit/questions_cubit.dart';
import 'package:baymax/pages/widgets/custom_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../core/color_manager.dart';
import '../core/navigation_functions.dart';
import '../core/text_style.dart';
import 'ecg_result_page.dart';
import 'results_page.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? image;
  File? file;
  FilePickerResult? result;

  final snackBar = const SnackBar(
    content: Text('Failed to pick file, please make sure to pick a .mat file'),
    backgroundColor: (Colors.black12),
  );

  Future pickImage(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Failed to pick image: $e');
    }
  }

  Future pickFile() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null && result!.files.single.path!.endsWith('mat')) {
      print(result!.files.single.path!);
      file = File(result!.files.single.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset(
                "assets/logo.png",
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    file != null
                        ? Text(
                            "File Name: ${result!.files.single.name}",
                            style: mainTextStyle.copyWith(
                                color: ColorManager.primaryColor),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonWidget(
                      onPressed: ()async {

                        await pickFile();
                        setState(() {
                          
                        });setState(() {
                          
                        });
                      },
                      text: "pick file",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    file != null
                        ? ElevatedButton(
                            onPressed: () {
                              QuestionsCubit.get(context)
                                  .submitFileAndGetResult(file!);
                              navigateTo(context, const ResultsECGPage());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: ColorManager.primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "get results",
                              style: mainTextStyle.copyWith(
                                  color: ColorManager.primaryColor),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
