// ignore_for_file: prefer_interpolation_to_compose_strings

class LeetCodeRequests {
  final String operationName;
  final Variables variables;
  final String query;

  LeetCodeRequests({
    required this.operationName,
    required this.variables,
    required this.query,
  });

  Map<String, dynamic> toJson() {
    return {
      'operationName': operationName,
      'variables': variables.toJson(),
      'query': query,
    };
  }

  // Helper methods for creating specific requests
  static LeetCodeRequests generalDiscussionRequest(
      int limit, List<String> categories) {
    return LeetCodeRequests(
        operationName: "categoryTopicList",
        variables: Variables(
          orderBy: "hot",
          query: "",
          skip: 0,
          first: limit,
          categories: categories,
        ),
        query: "query categoryTopicList(\$categories: [String!]!, \$first: Int!, \$orderBy: TopicSortingOption, \$skip: Int, \$query: String, \$tags: [String!]) { categoryTopicList"
                "(categories: \$categories, orderBy: \$orderBy, skip: \$skip, query: \$query, first: \$first, tags: \$tags) { ...TopicsList } } fragment TopicsList on TopicConnection " +
            "{ totalNum  edges {  node {  id title commentCount  viewCount  tags { name slug } post { id voteCount creationDate author { username profile { userAvatar } } } } } }");
  }

  static LeetCodeRequests generalDiscussionItemRequest(int? topicId) {
    return LeetCodeRequests(
        operationName: "DiscussTopic",
        variables: Variables(
          topicId: topicId,
        ),
        query:
            "query DiscussTopic(\$topicId: Int!) { topic(id: \$topicId) { id viewCount topLevelCommentCount title pinned tags post { ...DiscussPost } } }"
            "fragment DiscussPost on PostNode { id voteCount content updationDate creationDate author { username profile { userAvatar reputation } } } ");
  }

  static LeetCodeRequests getUserProfileRequest(String userName) {
    return LeetCodeRequests(
        operationName: "getUserProfile",
        variables: Variables(
          username: userName,
          query: "",
        ),
        query: "query getUserProfile(\$username: String!) { allQuestionsCount { difficulty count __typename } matchedUser(username: \$username) { username socialAccounts githubUrl contributions { points questionCount"
                " testcaseCount __typename } profile { realName websites countryName skillTags company school starRating aboutMe userAvatar reputation ranking __typename } submissionCalendar submitStats: submitStatsGlobal" +
            " { acSubmissionNum { difficulty count submissions __typename } totalSubmissionNum { difficulty count submissions __typename } __typename } badges { id displayName icon creationDate medal { slug config " +
            "{ icon iconGif iconGifBackground iconWearing __typename } __typename } __typename } upcomingBadges { name icon __typename } activeBadge { id __typename } __typename } } ");
  }

  static LeetCodeRequests getDailyQuestion() {
    return LeetCodeRequests(
      operationName: "",
      variables: Variables(),
      query: """
          query questionOfToday {
              activeDailyCodingChallengeQuestion {
                date
                userStatus
                link
                question {
                  acRate
                  difficulty
                  freqBar
                  frontendQuestionId: questionFrontendId
                  isFavor
                  paidOnly: isPaidOnly
                  status
                  title
                  titleSlug
                  hasVideoSolution
                  hasSolution
                }
              }
            }
      """,
    );
  }

  static LeetCodeRequests getQuestionContent(String? titleSlug) {
    return LeetCodeRequests(
      operationName: "questionData",
      variables: Variables(
        titleSlug: titleSlug,
      ),
      query: '''
      query questionData(\$titleSlug: String!) {
        question(titleSlug: \$titleSlug) {
          questionId
          frontendQuestionId: questionFrontendId
          title
          titleSlug
          content
          isPaidOnly
          difficulty
          likes
          dislikes
          exampleTestcases
          categoryTitle
          topicTags {
            name
            slug
            translatedName
          }
          stats
          hints
          solution {
            id
            canSeeDetail
            paidOnly
            hasVideoSolution
            paidOnlyVideo
          }
        }
      }
    ''',
    );
  }

  static LeetCodeRequests getAllQuestionsRequest(
      String categorySlug, int limit, Filters filters) {
    return LeetCodeRequests(
        operationName: "problemsetQuestionList",
        variables: Variables(
          skip: 0,
          categorySlug: categorySlug,
          limit: limit,
          filters: filters,
        ),
        query: "query problemsetQuestionList(\$categorySlug: String, \$limit: Int, \$skip: Int, \$filters: QuestionListFilterInput) { problemsetQuestionList: questionList(    "
                "categorySlug: \$categorySlug limit: \$limit skip: \$skip filters: \$filters) {total: totalNum questions: data {acRate difficulty frontendQuestionId: questionFrontendId  " +
            "paidOnly: isPaidOnly     title titleSlug topicTags { name id     slug }hasSolution } } }");
  }

  // Additional methods for other requests can follow the same pattern...
}

class Variables {
  final String? username;
  final String? titleSlug;
  final String? categorySlug;
  final String? orderBy;
  final String? query;
  final int? skip;
  final int? first;
  final List<String>? categories;
  final Filters? filters;
  final String? questionId;
  final int? topicId;
  final List<String>? tags;
  final int? limit;

  Variables({
    this.username,
    this.titleSlug,
    this.categorySlug,
    this.orderBy,
    this.query,
    this.skip,
    this.first,
    this.categories,
    this.filters,
    this.questionId,
    this.topicId,
    this.tags,
    this.limit,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'titleSlug': titleSlug,
      'categorySlug': categorySlug,
      'orderBy': orderBy,
      'query': query,
      'skip': skip,
      'first': first,
      'categories': categories,
      'filters': filters?.toJson(),
      'questionId': questionId,
      'topicId': topicId,
      'tags': tags,
      'limit': limit,
    };
  }
}

class Filters {
  final List<String?>? tags;
  final String? orderBy;
  final String? searchKeywords;
  final String? listId;
  final String? difficulty;

  Filters({
    this.tags,
    this.orderBy,
    this.searchKeywords,
    this.listId,
    this.difficulty,
  });

  Map<String, dynamic> toJson() {
    return {
      'tags': tags,
      'orderBy': orderBy,
      'searchKeywords': searchKeywords,
      'listId': listId,
      'difficulty': difficulty,
    };
  }
}
