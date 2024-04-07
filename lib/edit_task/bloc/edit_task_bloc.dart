import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:task_manager_app/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:tasks_api/tasks_api.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc({
    required TasksOverviewBloc tasksOverviewBloc,
    required InternetTasks internetTasks,
    required Task? initialTask,
  })  : _internetTasks = internetTasks,
        _tasksOverviewBloc = tasksOverviewBloc,
        nameEditingController = TextEditingController(),
        colorEditingController = TextEditingController(),
        yearEditingController = TextEditingController(),
        pantoneValueEditingController = TextEditingController(),
        super(
          EditTaskState(
            initialTask: initialTask,
            name: initialTask?.name ?? '',
            color: initialTask?.color ?? '',
            pantoneValue: initialTask?.pantoneValue ?? '',
            year: initialTask?.year ?? 0,
          ),
        ) {
    on<EditTaskNameChanged>(_onNameChanged);
    on<EditTaskYearChanged>(_onYearChanged);
    on<EditTaskColorChanged>(_onColorChanged);
    on<EditTaskPantoneValueChanged>(_onPantoneValueChanged);
    on<EditTaskSubmitted>(_onSubmitted);

    setOfInts.add(Random().nextInt(1000));
  }

  final InternetTasks _internetTasks;
  final TasksOverviewBloc _tasksOverviewBloc;

  final TextEditingController nameEditingController;
  final TextEditingController colorEditingController;
  final TextEditingController yearEditingController;
  final TextEditingController pantoneValueEditingController;

  int initialMax = 1000;
  Set<int> setOfInts = {};

  void _onNameChanged(
    EditTaskNameChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(name: event.name));

  void _onYearChanged(
    EditTaskYearChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(year: event.year));

  void _onColorChanged(
    EditTaskColorChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(color: event.color));

  void _onPantoneValueChanged(
    EditTaskPantoneValueChanged event,
    Emitter<EditTaskState> emit,
  ) =>
      emit(state.copyWith(pantoneValue: event.pantoneValue));

  Future<void> _onSubmitted(
    EditTaskSubmitted event,
    Emitter<EditTaskState> emit,
  ) async {
    emit(state.copyWith(status: EditTaskStatus.loading));
    final task =
        (state.initialTask ?? const Task(name: '', year: 0, pantoneValue: ''))
            .copyWith(
      id: state.initialTask?.id,
      name: state.name,
      year: state.year,
      pantoneValue: state.pantoneValue,
      color: state.color,
    );

    try {
      var savedTask = await _internetTasks.saveTask(task);
      var newTask = savedTask.copyWith();
      if (state.initialTask == null) {
        if (setOfInts.isEmpty) {
          initialMax += 1000;
          setOfInts.add(initialMax);
        }
        newTask = savedTask.copyWith(id: setOfInts.first);
        setOfInts.remove(setOfInts.first);
      }
      _tasksOverviewBloc.add(TasksOverviewTaskAdd(newTask));
      emit(state.copyWith(status: EditTaskStatus.success));
    } catch (e) {
      // print(e);
      emit(state.copyWith(status: EditTaskStatus.failure));
    }
  }

  // Form
  final formKey = GlobalKey<FormState>();

  bool checkValidation() => formKey.currentState!.validate();

  // Time Picker
  // Future<void> selectDateTime(BuildContext context) async {
  //   await _selectDate(context);
  //   await _selectTime(context);
  // }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: state.pickedDateTime ?? DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked == null || picked == state.pickedDateTime) return;
  //   add(EditTaskColorChanged(picked));
  // }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: state.pickedDateTime == null
  //         ? TimeOfDay.now()
  //         : TimeOfDay.fromDateTime(state.pickedDateTime!),
  //   );

  //   if (pickedTime == null) return;
  //   if (pickedTime == TimeOfDay.fromDateTime(state.pickedDateTime!)) return;

  //   add(
  //     EditTaskColorChanged(
  //       state.pickedDateTime!.add(
  //         Duration(
  //           hours: pickedTime.hour,
  //           minutes: pickedTime.minute,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Future<void> close() {
    nameEditingController.dispose();
    colorEditingController.dispose();
    yearEditingController.dispose();
    pantoneValueEditingController.dispose();
    return super.close();
  }
}
