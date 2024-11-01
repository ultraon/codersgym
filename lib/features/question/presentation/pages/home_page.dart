import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myapp/core/api/api_state.dart';
import 'package:myapp/core/routes/app_router.gr.dart';
import 'package:myapp/features/question/domain/model/question.dart';
import 'package:myapp/features/question/presentation/blocs/daily_challenge/daily_challenge_cubit.dart';
import 'package:myapp/features/question/presentation/pages/question_detail_page.dart';
import 'package:myapp/features/question/presentation/widgets/daily_question_card.dart';
import 'package:myapp/features/question/presentation/widgets/user_greeting_card.dart';
import 'package:myapp/injection.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyChallengeCubit = getIt.get<DailyChallengeCubit>();
    useEffect(
      () {
        dailyChallengeCubit.getTodayChallenge();
        return null;
      },
    );
    return Scaffold(
      body: BlocBuilder<DailyChallengeCubit, ApiState>(
        bloc: dailyChallengeCubit,
        builder: (context, state) {
          return state.when(
            onInitial: () {
              return const Center(child: CircularProgressIndicator());
            },
            onLoading: () {
              return const Center(child: CircularProgressIndicator());
            },
            onLoaded: (question) {
              return HomePageBody(
                question: question,
              );
            },
            onError: (exception) {
              return Text(exception.toString());
            },
          );
        },
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
    required this.question,
  });
  final Question question;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const UserGreetingCard(
              userName: 'Gourav Sharma',
              avatarUrl:
                  "https://assets.leetcode.com/users/avatars/avatar_1638287294.png",
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Ready For Today's Challenge",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DailyQuestionCard(
              question: question,
              onSolveTapped: () {
                AutoRouter.of(context).push(
                  QuestionDetailRoute(question: question),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
