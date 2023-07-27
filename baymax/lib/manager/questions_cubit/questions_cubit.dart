import 'dart:convert';
import 'dart:io';

import 'package:baymax/core/constant.dart';
import 'package:baymax/data/models/questions_model.dart';
import 'package:baymax/data/repos/questions_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit(this.questioonsRepo) : super(QuestionsInitial());

  final QuestionsRepo questioonsRepo;
  static QuestionsCubit get(context) => BlocProvider.of(context);

  List<Questions> questions = [];

  int currentQuestionIndex = 0;

  void getQusetions() async {
    emit(QuestionsLoading());
    try {
      questions = await questioonsRepo.getQuestions();
      emit(QuestionsLoaded());
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  var client = http.Client();

  double results = 0;

  void submitDataAndGetResult() async {
    emit(SubmitLoading());
    List<String> answers = [];
    for (Questions q in questions) {
      answers.add(q.answer);
    }
    try {
      print("object");
      Map<String, dynamic> data = {'data': answers};
      var response = await client.post(Uri.http(BASE_URL, predictEndpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));
      var decodedResponse = jsonDecode(response.body) as Map;
      print(decodedResponse['prediction']);
      results = double.parse(decodedResponse['prediction']);

      emit(SubmitLoaded());
    } catch (e) {
      print(e.toString());
      emit(SubmitError(e.toString()));
    }
  }

  List<int> ecgResults = [];
  void submitFileAndGetResult(File file) async {
    emit(SubmitLoading());
    try {
      var request = new http.MultipartRequest(
          "POST", Uri.parse('http://' + BASE_URL + predictECGEndpoint));

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: "data.mat",
      ));
      var res = await request.send();

      var response = await http.Response.fromStream(res);
      var decodedResponse = jsonDecode(response.body) as Map;
      print(decodedResponse['prediction']);
      List<dynamic> stringList = json.decode(decodedResponse['prediction']) as List<dynamic>;

      // Check the type of the list.
      if (stringList is List<double>) {
        // The list is already a list of doubles, so no need to cast it.
      } else {
        // The list is not a list of doubles, so convert it to a list of doubles.
        stringList = List<double>.from(stringList);
      }

      // Convert each string in the list to a int
      List<int> floatList = stringList.map((e) => e.toInt()).toList();

  // Convert each string in the list to a float.
      //  List<int> floatList = stringList.map((e) => int.parse(e)).toList();
      ecgResults = floatList;
      emit(SubmitECGLoaded(ecgResults));
    } catch (e) {
      print(e.toString());
      emit(SubmitError(e.toString()));
    }
  }
}
