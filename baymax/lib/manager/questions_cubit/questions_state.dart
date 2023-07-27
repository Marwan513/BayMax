part of 'questions_cubit.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {}

class QuestionsError extends QuestionsState {
  final String error;

  const QuestionsError(this.error);
}

class SubmitLoading extends QuestionsState {}
class SubmitLoaded extends QuestionsState {}
class SubmitECGLoaded extends QuestionsState {
  final List<int> ecgResults;

  const SubmitECGLoaded(this.ecgResults);
}
class SubmitError extends QuestionsState {
  final String error;

  const SubmitError(this.error);
}

