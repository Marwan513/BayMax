import 'dart:ffi';

import 'package:baymax/core/navigation_functions.dart';
import 'package:baymax/core/text_style.dart';
import 'package:baymax/manager/questions_cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'home_page.dart';

class ResultsECGPage extends StatefulWidget {
  const ResultsECGPage({super.key});

  @override
  State<ResultsECGPage> createState() => _ResultsECGPageState();
}

class _ResultsECGPageState extends State<ResultsECGPage> {
  @override
  void initState() {
    super.initState();
  }

  List<String> list = [
    "Sinus Bradycardia",
    "Sinus Rhythm",
    "Atrial Flutter",
    "Sinus Tachycardia",
    "T-Wave Changes",
    "Left Ventricular Hypertrophy",
    "ST Changes",
    "T-Wave Opposite",
    "Sinus Arrest",
    "Atrial Fibrillation",
    "ST Drop Down",
    "Axis Left Shift"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigateToAndReplace(context, const HomePage());
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: BlocConsumer<QuestionsCubit, QuestionsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<int>? results = BlocProvider.of<QuestionsCubit>(context).ecgResults;
          return state is SubmitLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is SubmitError
                  ? Center(
                      child: Text(state.error),
                    )
                  : state is SubmitECGLoaded? Column(
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
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${list[index]}",
                                              style: mainTextStyle.copyWith(
                                                  color: Colors.black,fontSize: 14),
                                            ),

                                            Icon(
                                              state.ecgResults[index]==1?Icons.check:Icons.close,
                                              color: state.ecgResults[index]==1? Colors.green:Colors.red,
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount: list.length,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ):SizedBox();
        },
      ),
    );
  }
}
