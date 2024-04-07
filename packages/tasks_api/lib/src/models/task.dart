import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'task.g.dart';

/// {@template task_item}
/// A single `task` item.
///
/// Contains a [name], [color], [year], [pantoneValue] and [id].
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Task]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Task extends Equatable {
  /// {@macro task_item}
  const Task({
    required this.name,
    required this.year,
    required this.pantoneValue,
    int? id,
    this.color = '',
  }) : id = id ?? 0;

  /// The unique identifier of the `task`.
  ///
  /// Cannot be empty.
  final int id;

  /// The name of the `task`.
  ///
  /// Note that the name may be empty.
  final String name;

  /// The year of the `task`.
  ///
  /// Note that the year may be zero.
  final int year;

  /// The pantoneValue of the `task`.
  final String pantoneValue;

  /// The color of the `task`.
  ///
  /// Defaults to an empty string.
  final String color;

  /// Returns a copy of this `task` with the given values updated.
  ///
  /// {@macro task_item}
  Task copyWith({
    int? id,
    String? name,
    int? year,
    String? pantoneValue,
    String? color,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      year: year ?? this.year,
      pantoneValue: pantoneValue ?? this.pantoneValue,
      color: color ?? this.color,
    );
  }

  /// Deserializes the given [Map<String, dynamic>] into a [Task].
  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Converts this [Task] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object> get props => [id, name, color, year, pantoneValue];
}
