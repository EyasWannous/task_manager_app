part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

final class EditTaskNameChanged extends EditTaskEvent {
  const EditTaskNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class EditTaskYearChanged extends EditTaskEvent {
  const EditTaskYearChanged(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class EditTaskColorChanged extends EditTaskEvent {
  const EditTaskColorChanged(this.color);

  final String color;

  @override
  List<Object> get props => [color];
}

final class EditTaskPantoneValueChanged extends EditTaskEvent {
  const EditTaskPantoneValueChanged(this.pantoneValue);

  final String pantoneValue;

  @override
  List<Object> get props => [pantoneValue];
}

final class EditTaskSubmitted extends EditTaskEvent {
  const EditTaskSubmitted();
}
