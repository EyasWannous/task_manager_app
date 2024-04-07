part of 'edit_task_bloc.dart';

enum EditTaskStatus { initial, loading, success, failure }

extension EditTaskStatusX on EditTaskStatus {
  bool get isLoadingOrSuccess => [
        EditTaskStatus.loading,
        EditTaskStatus.success,
      ].contains(this);
}

final class EditTaskState extends Equatable {
  const EditTaskState({
    this.status = EditTaskStatus.initial,
    this.initialTask,
    this.name = '',
    this.year = 0,
    this.pantoneValue = '',
    this.color = '',
  });

  final EditTaskStatus status;
  final Task? initialTask;
  final String name;
  final int year;
  final String pantoneValue;
  final String color;

  bool get isNewTask => initialTask == null;

  EditTaskState copyWith({
    EditTaskStatus? status,
    Task? initialTask,
    String? name,
    int? year,
    String? pantoneValue,
    String? color,
  }) {
    return EditTaskState(
      status: status ?? this.status,
      initialTask: initialTask ?? this.initialTask,
      name: name ?? this.name,
      year: year ?? this.year,
      pantoneValue: pantoneValue ?? this.pantoneValue,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialTask,
        name,
        year,
        pantoneValue,
        color,
      ];
}
