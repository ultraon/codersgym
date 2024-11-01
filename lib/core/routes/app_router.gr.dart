// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:myapp/features/question/domain/model/question.dart' as _i5;
import 'package:myapp/features/question/presentation/pages/home_page.dart'
    as _i1;
import 'package:myapp/features/question/presentation/pages/question_detail_page.dart'
    as _i2;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.QuestionDetailPage]
class QuestionDetailRoute extends _i3.PageRouteInfo<QuestionDetailRouteArgs> {
  QuestionDetailRoute({
    _i4.Key? key,
    required _i5.Question question,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          QuestionDetailRoute.name,
          args: QuestionDetailRouteArgs(
            key: key,
            question: question,
          ),
          initialChildren: children,
        );

  static const String name = 'QuestionDetailRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuestionDetailRouteArgs>();
      return _i2.QuestionDetailPage(
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

  final _i4.Key? key;

  final _i5.Question question;

  @override
  String toString() {
    return 'QuestionDetailRouteArgs{key: $key, question: $question}';
  }
}
