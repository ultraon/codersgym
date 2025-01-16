part of 'question_archieve_bloc.dart';

class QuestionArchieveState extends Equatable {
  final List<Question> questions;
  final bool isLoading;
  final Exception? error;
  final bool moreQuestionAvailable;
  const QuestionArchieveState({
    required this.questions,
    required this.isLoading,
    required this.error,
    required this.moreQuestionAvailable,
  });

  factory QuestionArchieveState.initial() {
    return const QuestionArchieveState(
      questions: [],
      isLoading: false,
      error: null,
      moreQuestionAvailable: true,
    );
  }
  QuestionArchieveState copyWith({
    List<Question>? questions,
    bool? isLoading,
    Exception? error,
    bool? moreQuestionAvailable,
  }) {
    return QuestionArchieveState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      moreQuestionAvailable:
          moreQuestionAvailable ?? this.moreQuestionAvailable,
    );
  }

  @override
  List<Object?> get props =>
      [questions, isLoading, error, moreQuestionAvailable];

       factory QuestionArchieveState.fromJson(Map<String, dynamic> json) {
    return QuestionArchieveState(
      questions: (json['questions'] as List<dynamic>)
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList(),
      isLoading: json['isLoading'] as bool,
      // Note: We can't properly deserialize Exception objects directly from JSON
      // so we'll store it as a string message
      error: json['error'] != null ? Exception(json['error'] as String) : null,
      moreQuestionAvailable: json['moreQuestionAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((q) => q.toJson()).toList(),
      'isLoading': isLoading,
      // Convert Exception to string for JSON serialization
      'error': error?.toString(),
      'moreQuestionAvailable': moreQuestionAvailable,
    };
  }
}
