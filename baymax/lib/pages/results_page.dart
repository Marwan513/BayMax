

import 'package:baymax/core/navigation_functions.dart';
import 'package:baymax/core/text_style.dart';
import 'package:baymax/manager/questions_cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'home_page.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    
    super.initState();
  }

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
          double? results = BlocProvider.of<QuestionsCubit>(context).results;
          return
          state is SubmitLoading? const Center(child: CircularProgressIndicator(),):state is SubmitError? Center(child: Text(state.error),):
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SimpleCircularProgressBar(
                    backColor: results < 50
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    animationDuration: 4,
                    backStrokeWidth: 25,
                    progressStrokeWidth: 25,
                    size: 120,
                    progressColors: [results < 50 ? Colors.green : Colors.red],
                    startAngle: 0,
                    valueNotifier: ValueNotifier<double>(results.toDouble()),
                    onGetText: (double value) {
                      return Text(
                        '${value.toInt()}%',
                        style: mainTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 30),
                      );
                    },
                  ),
                ),
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "logo",
                                child: Image.asset(
                                  "assets/logo.png",
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    results > 50
                                        ? "Dear...\n\nBaymax is sad to tell you that...\nYou have a heart disease, So I advise you to go to the doctor immeditately as soon as possible.\nBaymax is waiting for you to follow up after the examination in order to improve."
                                        : "Dear...\n\nBaymax is happy to tell that you are fine and do not have a heart disease, but you must maintain your health and follow up annually.\nBaymax wishes you good health and wellness.",
                                    style: mainTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
