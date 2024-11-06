import 'package:auto_route/auto_route.dart';
import 'package:dailycoder/features/common/widgets/app_pagination_list.dart';
import 'package:dailycoder/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dailycoder/features/question/presentation/blocs/question_archieve/question_archieve_bloc.dart';
import 'package:dailycoder/features/question/presentation/widgets/question_card.dart';
import 'package:dailycoder/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_router.gr.dart';

class ExploreSearchDelegate extends SearchDelegate<String> {
  final QuestionArchieveBloc _questionArchieveBloc;
  ExploreSearchDelegate(this._questionArchieveBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          // When pressed here the query will be cleared from the search bar.
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: const Text("Search questions"),
      );
    }
    _questionArchieveBloc.add(FetchQuestionsListEvent(
      searchKeyword: query,
      skip: 0,
    ));
    return BlocBuilder<QuestionArchieveBloc, QuestionArchieveState>(
      bloc: _questionArchieveBloc,
      builder: (context, state) {
        return AppPaginationList(
          itemBuilder: (BuildContext context, int index) {
            return QuestionCard(
              question: state.questions[index],
              onTap: () {
                AutoRouter.of(context).push(
                  QuestionDetailRoute(question: state.questions[index]),
                );
              },
            );
          },
          itemCount: state.questions.length,
          loadMoreData: () {
            _questionArchieveBloc.add(
              FetchQuestionsListEvent(
                searchKeyword: query,
              ),
            );
          },
          moreAvailable: state.moreQuestionAvailable,
        );
      },
    );
  }
}
