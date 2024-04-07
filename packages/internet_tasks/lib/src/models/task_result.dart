// ignore_for_file: public_member_api_docs

import 'package:internet_tasks/src/models/support.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasks_api/tasks_api.dart';

part 'task_result.g.dart';

@JsonSerializable()
class TaskResult {
  TaskResult({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory TaskResult.fromJson(Map<String, dynamic> json) =>
      _$TaskResultFromJson(json);

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Task>? data;
  Support? support;

  Map<String, dynamic> toJson() => _$TaskResultToJson(this);
}
