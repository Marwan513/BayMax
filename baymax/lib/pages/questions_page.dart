import 'package:baymax/core/color_manager.dart';
import 'package:baymax/core/navigation_functions.dart';
import 'package:baymax/core/text_style.dart';

import 'package:baymax/manager/questions_cubit/questions_cubit.dart';
import 'package:baymax/pages/widgets/answer_widget.dart';
import 'package:baymax/pages/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'results_page.dart';

// ignore: must_be_immutable
class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int selectedIndex = -1;

  @override
  void dispose() {
    super.dispose();
  }

//   Body Mass Index (BMI) is a person's weight in kilograms  divided by the square of height in meters. A high BMI can indicate high body fatness. BMI screens for weight categories that may lead to health problems, but it does not diagnose the body fatness or health of an individual. (Your weight / your height)
// Your BMI:
// Your BMI < 18.5  then 'underweight'
// Your BMI  < 25 then  'healthy weight'
// Your BMI  < 30 then 'overweight'
// Your BMI < 35   then  'obesity'
// Your BMI   < 40  then   'over obesity'
// Your BMI  < 50  then 'super obesity
//  50 > Your BMI then 'super super obesity'

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        QuestionsCubit cubit = QuestionsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    cubit.currentQuestionIndex = 0;
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ))),
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
              const SizedBox(
                height: 20,
              ),
              state is QuestionsLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        cubit.questions[cubit.currentQuestionIndex]
                                            .question!,
                                        textAlign: TextAlign.center,
                                        style: mainTextStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  cubit.currentQuestionIndex == 0
                                      ? InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return   Dialog(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10.0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Body Mass Index (BMI) is a person's weight in kilograms  divided by the square of height in meters. A high BMI can indicate high body fatness. BMI screens for weight categories that may lead to health problems, but it does not diagnose the body fatness or health of an individual. (Your weight / your height)",
                                                        style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                        ),
                                                        Text("Your BMI:",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("Your BMI < 18.5  then 'underweight'",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("Your BMI  < 25 then  'healthy weight'",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("Your BMI  < 30 then 'overweight'",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("Your BMI < 35   then  'obesity'",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("Your BMI   < 40  then   'over obesity'",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("Your BMI  < 50  then 'super obesity",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),
                                                        Text("50 > Your BMI then 'super super obesity'",style: mainTextStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                        ),),

                                                        CustomButtonWidget(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, 
                                                         text: "back")
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.help_outline_outlined,
                                            color: Colors.greenAccent.shade400,
                                            size: 40,
                                          ))
                                      : const SizedBox()
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return AnswersWidget(
                                      answer: cubit
                                          .questions[cubit.currentQuestionIndex]
                                          .options![index],
                                      isChosen: selectedIndex == index,
                                      index: index,
                                      onPressed: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 2,
                                    );
                                  },
                                  itemCount: cubit
                                      .questions[cubit.currentQuestionIndex]
                                      .options!
                                      .length,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: cubit.currentQuestionIndex == 0
                                          ? () {}
                                          : () {
                                              setState(() {
                                                cubit.currentQuestionIndex--;
                                                selectedIndex = -1;
                                              });
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            cubit.currentQuestionIndex == 0
                                                ? Colors.grey.shade200
                                                : Colors.redAccent.shade400,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child:  Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                         const  Icon(
                                            Icons.arrow_back_ios,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "previous",
                                             style: mainTextStyle.copyWith(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomButtonWidget(
                                     
                                      onPressed: selectedIndex == -1
                                          ? null
                                          : cubit.currentQuestionIndex ==
                                                  cubit.questions.length - 1
                                              ? () {
                                                cubit
                                                          .questions[cubit
                                                              .currentQuestionIndex]
                                                          .answer =
                                                      cubit
                                                          .questions[cubit
                                                              .currentQuestionIndex]
                                                          .options![selectedIndex];
                                                          cubit.submitDataAndGetResult();
                    cubit.currentQuestionIndex = 0;

                                                  navigateTo(context,
                                                      const ResultsPage());
                                                }
                                              : () {
                                                  cubit
                                                          .questions[cubit
                                                              .currentQuestionIndex]
                                                          .answer =
                                                      cubit
                                                          .questions[cubit
                                                              .currentQuestionIndex]
                                                          .options![selectedIndex];
                                                  setState(() {
                                                    selectedIndex = -1;
                                                    cubit
                                                        .currentQuestionIndex++;
                                                  });
                                                },
                                      color: selectedIndex == -1
                                          ? Colors.grey.shade200
                                          : ColorManager.primaryColor,
                                      text: cubit.currentQuestionIndex ==
                                              cubit.questions.length - 1
                                          ? "Submit"
                                          : "Next",
                                      hasIcon: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
