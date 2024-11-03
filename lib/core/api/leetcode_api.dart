import 'dart:async';

import 'package:dailycoder/core/utils/storage/storage_manager.dart';
import 'package:dailycoder/features/auth/data/service/auth_service.dart';
import 'package:dailycoder/injection.dart';
import 'package:exponential_back_off/exponential_back_off.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dailycoder/core/error/exception.dart';
import 'package:dailycoder/core/api/api_urls.dart';
import 'package:dailycoder/core/api/leetcode_requests.dart';

class LeetcodeApi {
  late GraphQLClient _graphQLClient;
  final StorageManager _storageManager;

  LeetcodeApi({GraphQLClient? client, required StorageManager storageManger})
      : _storageManager = storageManger {
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
    return _executeGraphQLQuery(request);
  }

  Future<Map<String, dynamic>?> getQuestionContent(String titleSlug) async {
    final request = LeetCodeRequests.getQuestionContent(titleSlug);
    return _executeGraphQLQuery(request);
  }

  Future<Map<String, dynamic>?> getUserProfile(String userName) async {
    final request = LeetCodeRequests.getUserProfileRequest(userName);
    return _executeGraphQLQuery(request);
  }

  Future<Map<String, dynamic>?> getGlobalData() async {
    final request = LeetCodeRequests.getGlobalData();
    return _executeGraphQLQuery(request);
  }

  Future<Map<String, dynamic>?> _executeGraphQLQuery(
      LeetCodeRequests request) async {
    try {
      final sessionToken =
          await _storageManager.getString(_storageManager.leetcodeSession);
      final queryOptions = QueryOptions(
        document: gql(request.query),
        variables: request.variables.toJson(),
        context: Context.fromList([
          HttpLinkHeaders(headers: {
            if (sessionToken != null)
              'Cookie': 'LEETCODE_SESSION=$sessionToken;',
          })
        ]),
      );
      final exponentialBackOff = ExponentialBackOff(
        interval: const Duration(milliseconds: 1000),
        maxAttempts: 3,
        maxRandomizationFactor: 1,
        maxDelay: const Duration(seconds: 3),
      );

      final queryResult = await exponentialBackOff.start(
        () => _graphQLClient
            .query(
          queryOptions,
        )
            .timeout(const Duration(milliseconds: 100), onTimeout: () {
          throw TimeoutException('Server Timeout');
        }),
        retryIf: (error) {
          return (error is TimeoutException);
        },
      );
      return queryResult.fold(
        (exception) {
          throw ApiServerException("Server Error", exception);
        },
        (result) {
          if (result.hasException) {
            throw ApiServerException("Server Error", result.exception);
          }
          return result.data;
        },
      );
    } catch (e) {
      if (e is ApiServerException) {
        rethrow;
      }
      throw ApiNoNetworkException("There was some network error", e);
    }
  }
}
