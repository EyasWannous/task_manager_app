import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_tasks/internet_tasks.dart';
import 'package:tasks_api/tasks_api.dart';

part 'tasks_overview_event.dart';
part 'tasks_overview_state.dart';

class TasksOverviewBloc extends Bloc<TasksOverviewEvent, TasksOverviewState> {
  TasksOverviewBloc(
    this.resultScrollController, {
    required InternetTasks internetTasks,
  })  : _internetTasks = internetTasks,
        super(const TasksOverviewState()) {
    on<TasksOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TasksOverviewTaskAdd>(_onTaskAddOrUpdated);
    on<TasksOverviewTaskDeleted>(_onTaskDeleted);

    // resultScrollController.addListener(() {
    //   bool hasClients = (resultScrollController.hasClients);
    //   bool isEnd = (resultScrollController.position.maxScrollExtent ==
    //       resultScrollController.position.pixels);
    //   bool isNewEnd = (resultScrollController.position.maxScrollExtent !=
    //       lastPixelsPosition);

    //   if (hasClients && isEnd && isNewEnd) {
    //     lastPixelsPosition = resultScrollController.position.pixels;
    //     pageNumber++;
    //     add(const TasksOverviewSubscriptionRequested());
    //     // print(lastPixelsPosition);
    //   }
    // });
  }

  void _onTaskAddOrUpdated(
      TasksOverviewTaskAdd event, Emitter<TasksOverviewState> emit) {
    emit(state.copyWith(status: () => TasksOverviewStatus.loading));

    final contains =
        tasksResult.indexWhere((element) => element.id == event.task.id);
    if (contains > -1) {
      tasksResult[contains] = event.task;
    } else {
      tasksResult.add(event.task);
    }

    emit(state.copyWith(
      status: () => TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  final ScrollController resultScrollController;
  double lastPixelsPosition = 0;

  final InternetTasks _internetTasks;
  final List<Task> tasksResult = [];
  int pageNumber = 1;
  int perPage = 4;
  // int total = 0;
  // bool endOfAll = false;

  Future<void> _onSubscriptionRequested(
    TasksOverviewSubscriptionRequested event,
    Emitter<TasksOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TasksOverviewStatus.loading));
    // print(pageNumber);

    TaskResult? currentTasks = await _internetTasks.getTasks(
        pageNumber.toString(), perPage.toString());

    if (currentTasks == null || currentTasks.data == null) {
      emit(state.copyWith(status: () => TasksOverviewStatus.failure));
    }

    if (pageNumber == 1) {
      tasksResult.clear();

      if (currentTasks?.data == null || currentTasks!.data!.isEmpty) {
        emit(state.copyWith(
          status: () => TasksOverviewStatus.success,
          tasks: tasksResult,
        ));
        return;
      }

      tasksResult.insertAll(0, currentTasks.data!);
      // tasksResult.addAll(currentTasks.data!);
      // total = currentTasks.total ?? 0;
      // if (total == tasksResult.length) {
      //   endOfAll = true;
      // }

      emit(state.copyWith(
        status: () => TasksOverviewStatus.success,
        tasks: tasksResult,
      ));
      return;
    }

    if (currentTasks?.data != null && currentTasks!.data!.isNotEmpty) {
      tasksResult.insertAll(0, currentTasks.data!);
      // tasksResult.addAll(currentTasks.data!);
    }

    // total = currentTasks.total ?? 0;
    // if (total == tasksResult.length) {
    //   endOfAll = true;
    // }

    emit(state.copyWith(
      status: () => TasksOverviewStatus.success,
      tasks: tasksResult,
    ));
  }

  Future<void> _onTaskDeleted(
    TasksOverviewTaskDeleted event,
    Emitter<TasksOverviewState> emit,
  ) async {
    // emit(state.copyWith(lastDeletedTask: () => event.task));
    try {
      await _internetTasks.deleteTask(event.task.id);
      tasksResult.remove(event.task);
      emit(state.copyWith(lastDeletedTask: () => event.task));
    } catch (e) {
      // print(e);
    }
  }

  Future<void> onRefresh() async {
    pageNumber = (tasksResult.length / perPage).floor();
    pageNumber++;
    add(const TasksOverviewSubscriptionRequested());
  }
}
