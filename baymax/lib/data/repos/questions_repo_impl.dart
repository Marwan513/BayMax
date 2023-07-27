import 'dart:convert';

import 'package:baymax/data/models/questions_model.dart';
import 'package:baymax/data/repos/questions_repo.dart';
import 'package:flutter/services.dart';

class QuestionsRepoImpl implements QuestionsRepo {
  @override
  Future<List<Questions>> getQuestions() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final questionsModel = QusetionsModel.fromJson(jsonMap);
      return questionsModel.questions!;
    } on Exception {
      throw Exception("can't load file");
    }
  }
}
