import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dailycoder/core/error/exception.dart';
import 'package:dailycoder/core/api/api_urls.dart';
import 'package:dailycoder/core/api/leetcode_requests.dart';

class LeetcodeApi {
  late GraphQLClient _graphQLClient;

  LeetcodeApi({GraphQLClient? client}) {
    _graphQLClient = client ??
        GraphQLClient(
          link: HttpLink(
            ApiUrls.leetcodeGraphql,
          ),
          cache: GraphQLCache(),
        );
  }

  Future<Map<String, dynamic>?> getDailyQuestion() async {
    final request = LeetCodeRequests.getDailyQuestion();
    final queryOptions = QueryOptions(
      document: gql(request.query),
      variables: request.variables.toJson(),
    );

    return _executeGraphQLQuery(queryOptions);
  }

  Future<Map<String, dynamic>?> getQuestionContent(String titleSlug) async {
    final request = LeetCodeRequests.getQuestionContent(titleSlug);
    final queryOptions = QueryOptions(
      document: gql(request.query),
      variables: request.variables.toJson(),
    );

    return _executeGraphQLQuery(queryOptions);
  }

  Future<Map<String, dynamic>?> _executeGraphQLQuery(
      QueryOptions queryOptions) async {
    try {
      final queryResult = await _graphQLClient.query(queryOptions);
      if (queryResult.hasException) {
        throw ApiServerException("Server Error", queryResult.exception);
      } else {
        return queryResult.data;
      }
    } catch (e) {
      if (e is ApiServerException) {
        rethrow;
      }
      throw ApiNoNetworkException("There was some network error", e);
    }
  }
}
