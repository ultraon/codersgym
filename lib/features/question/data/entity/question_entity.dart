import 'package:dailycoder/features/question/domain/model/question.dart';

class QuestionNodeEntity {
  String? title;
  String? titleSlug;
  String? difficulty;
  double? acRate;
  bool? paidOnly;
  String? frontendQuestionId;
  bool? hasVideoSolution;
  bool? hasSolution;
  String? content;
  List<TopicTagsNodeEntity>? topicTags;
  Null? freqBar;
  bool? isFavor;
  Null? status;

  QuestionNodeEntity({
    this.title,
    this.titleSlug,
    this.difficulty,
    this.acRate,
    this.paidOnly,
    this.frontendQuestionId,
    this.hasVideoSolution,
    this.hasSolution,
    this.topicTags,
    this.content,
  });

  QuestionNodeEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleSlug = json['titleSlug'];
    difficulty = json['difficulty'];
    acRate = json['acRate']?.toDouble();
    paidOnly = json['paidOnly'];
    frontendQuestionId = json['frontendQuestionId'];
    hasVideoSolution = json['hasVideoSolution'];
    hasSolution = json['hasSolution'];
    content = json['content'];
    if (json['topicTags'] != null) {
      topicTags = [];
      json['topicTags'].forEach((v) {
        topicTags!.add(TopicTagsNodeEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'titleSlug': titleSlug,
      'difficulty': difficulty,
      'acRate': acRate,
      'paidOnly': paidOnly,
      'content': content,
      'frontendQuestionId': frontendQuestionId,
      'hasVideoSolution': hasVideoSolution,
      'hasSolution': hasSolution,
      'topicTags': topicTags?.map((v) => v.toJson()).toList(),
    };
  }
}

class TopicTagsNodeEntity {
  String? name;
  String? id;
  String? slug;

  TopicTagsNodeEntity({this.name, this.id, this.slug});

  TopicTagsNodeEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'slug': slug,
    };
  }
}

extension QuestionNodeEntityExt on QuestionNodeEntity {
  Question toQuestion() {
    return Question(
      title: title,
      titleSlug: titleSlug,
      difficulty: difficulty,
      acRate: acRate,
      paidOnly: paidOnly,
      frontendQuestionId: frontendQuestionId,
      hasVideoSolution: hasVideoSolution,
      hasSolution: hasSolution,
      content: content,
      topicTags: topicTags?.map((tag) => tag.toTopicTags()).toList(),
    );
  }
}

extension TopicTagsNodeEntityExt on TopicTagsNodeEntity {
  TopicTags toTopicTags() {
    return TopicTags(id: id, name: name, slug: slug);
  }
}
