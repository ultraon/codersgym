import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/core/routes/app_router.gr.dart';
import 'package:dailycoder/features/common/widgets/app_pagination_list.dart';
import 'package:dailycoder/features/question/domain/model/question.dart';
import 'package:dailycoder/features/question/presentation/blocs/question_archieve/question_archieve_bloc.dart';
import 'package:dailycoder/features/question/presentation/widgets/question_difficulty_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExplorePage extends HookWidget {
  const ExplorePage({super.key});

  Widget _buildProblemTile(BuildContext context, Question problem) {
    return ListTile(
      title: Text(
        problem.title ?? "",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          // color: problem.isSolved ? Colors.green : Colors.black,
        ),
      ),
      subtitle: QuestionDifficultyText(problem),
      // trailing: Icon(
      //   problem.isSolved ? Icons.check_circle : Icons.circle,
      //   color: problem.isSolved ? Colors.green : Colors.grey,
      // ),
      onTap: () {
        AutoRouter.of(context).push(
          QuestionDetailRoute(question: problem),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionArchieveBloc = context.read<QuestionArchieveBloc>();
    useEffect(() {
      questionArchieveBloc.add(const FetchQuestionsListEvent());
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Problem List"),
      ),
      body: BlocBuilder<QuestionArchieveBloc, QuestionArchieveState>(
        builder: (context, state) {
          return AppPaginationList(
            itemBuilder: (BuildContext context, int index) {
              return _buildProblemTile(
                context,
                state.questions[index],
              );
            },
            itemCount: state.questions.length,
            loadMoreData: () {
              questionArchieveBloc.add(
                const FetchQuestionsListEvent(),
              );
            },
            moreAvailable: state.moreQuestionAvailable,
          );
        },
      ),
    );
  }
}
