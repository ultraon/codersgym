import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myapp/core/api/api_state.dart';
import 'package:myapp/features/question/domain/model/question.dart';
import 'package:myapp/features/question/presentation/blocs/question_content/question_content_cubit.dart';
import 'package:myapp/features/question/presentation/widgets/question_difficulty_text.dart';
import 'package:myapp/injection.dart';

@RoutePage()
class QuestionDetailPage extends HookWidget {
  final Question question;
  const QuestionDetailPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final questionContentCubit = getIt.get<QuestionContentCubit>();
    useEffect(
      () {
        questionContentCubit.getQuestionContent(question);
        return null;
      },
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: BlocBuilder<QuestionContentCubit,
                ApiState<Question, Exception>>(
              bloc: questionContentCubit,
              builder: (context, state) {
                return state.when(
                  onInitial: () => const CircularProgressIndicator(),
                  onLoading: () => const CircularProgressIndicator(),
                  onLoaded: (question) {
                    return QuestionDetailPageBody(
                      question: question,
                    );
                  },
                  onError: (exception) => Text(exception.toString()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionDetailPageBody extends StatelessWidget {
  const QuestionDetailPageBody({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              ("${question.frontendQuestionId}. ") + (question.title ?? ""),
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            QuestionDifficultyText(question),
            HtmlWidget(
              question.content ?? '',
              renderMode: RenderMode.column,
              textStyle: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
