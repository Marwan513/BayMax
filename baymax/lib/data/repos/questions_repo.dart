import '../models/questions_model.dart';

abstract class QuestionsRepo {
  Future<List<Questions>> getQuestions();
}