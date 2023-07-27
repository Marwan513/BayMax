import 'package:baymax/data/repos/questions_repo_impl.dart';
import 'package:baymax/manager/questions_cubit/questions_cubit.dart';

import 'package:baymax/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuestionsCubit>(
          create: (context) => QuestionsCubit(QuestionsRepoImpl())..getQusetions(),
        ),
      ],
      child: MaterialApp(
        title: 'Baymax',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
