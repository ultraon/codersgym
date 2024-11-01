// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:dailycoder/features/auth/presentation/pages/leetcode_web_page.dart'
    as _i2;
import 'package:dailycoder/features/auth/presentation/pages/login_page.dart'
    as _i3;
import 'package:dailycoder/features/question/domain/model/question.dart' as _i7;
import 'package:dailycoder/features/question/presentation/pages/home_page.dart'
    as _i1;
import 'package:dailycoder/features/question/presentation/pages/question_detail_page.dart'
    as _i4;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LeetcodeWebPage]
class LeetcodeWebRoute extends _i5.PageRouteInfo<void> {
  const LeetcodeWebRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LeetcodeWebRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeetcodeWebRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LeetcodeWebPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.QuestionDetailPage]
class QuestionDetailRoute extends _i5.PageRouteInfo<QuestionDetailRouteArgs> {
  QuestionDetailRoute({
    _i6.Key? key,
    required _i7.Question question,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          QuestionDetailRoute.name,
          args: QuestionDetailRouteArgs(
            key: key,
            question: question,
          ),
          initialChildren: children,
        );

  static const String name = 'QuestionDetailRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestionDetailRouteArgs>();
      return _i4.QuestionDetailPage(
        key: args.key,
        question: args.question,
      );
    },
  );
}

class QuestionDetailRouteArgs {
  const QuestionDetailRouteArgs({
    this.key,
    required this.question,
  });

  final _i6.Key? key;

  final _i7.Question question;

  @override
  String toString() {
    return 'QuestionDetailRouteArgs{key: $key, question: $question}';
  }
}
